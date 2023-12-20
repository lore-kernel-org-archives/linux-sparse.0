Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFBBA31
	for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2023 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nT2K1vsj"
Received: from [10.0.2.15] ([146.198.40.91])
	by smtp with ESMTPA
	id FkHrrDkvZSP25FkHsrwqBk; Wed, 20 Dec 2023 00:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1703031492; bh=8wv9D5ksI8tzF+DVjJytMXlwlG3zbQEWvCvbkIELs/I=;
	h=Date:To:Cc:From:Subject;
	b=nT2K1vsjy1eAmWz4LppSiqNedhVFXuh94kcqP/6VFs3CTnfFTBnZ6Yp9/322uKoF8
	 kZz1MOTm/nkULe/Fmy8tO9ekZ/SZ0MeFGYFEPC4iGOrE5pdc8PBr1ZV2LgFRRcB1yF
	 NKAswbc2Ekch7b2QzVgvRMrMEZADahjUyt5fAOTBXFz/pB4nDR4i5lxebHTJNZqanr
	 x5qITuT1yyqTE25p6AGh0dBGAg/Cmc6xdQlbuYoWPa87lEwBzALZkzt00wLMKmFEls
	 AFcDtrJOcrPJMTmp/nCw7N+SLF4PTvhaUTiGk/laSbeQIqmRu+xMSBkCTg7HyPh02y
	 e22k15aFM0/YQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=I+Z2+fsg c=1 sm=1 tr=0 ts=658232c4
 a=KA9ncW3+NP+rNtcBcdh9kA==:117 a=KA9ncW3+NP+rNtcBcdh9kA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=JkTcleHpADUx7VeXBVUA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <6f853a6b-9ac3-4bfd-a968-89d43fbcce2a@ramsayjones.plus.com>
Date: Wed, 20 Dec 2023 00:18:11 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: sparse regex error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLHNok8GL4cCXKwMPb3oQcLLZayk28n6+CY7zrwXvC3/An3+Pp9Ma7dYuAKY/Qv3RnHoa5SXkgz2RypT/jTkLTEZR1LIjNvKPAdiUr/2WEZU31hsltZu
 9hbtcA8Gm74KGZZYPiZDG2ePRlAlge+vKA2VtNizvktsg6a2mBywK4S9+nD1CwHDrvIrMhipZ8xNYXy+ra6GMhsQGqA1ncmTTi0=

Hi Luc,

Long time no hear! ;)

About 18 months ago, I updated my Linux installation and sparse started
to fail when run during my git build. The reason for the failure was,
ultimately, a change to the 'regex.h' header file as a result of the
update from one Ubuntu LTS base to the current Ubuntu LTS base.
In particular, an update to the libc6-devel package from 2.31 to 2.35
which (in part) looked like this:

.

524a525,548
> #ifndef _REGEX_NELTS
> # if (defined __STDC_VERSION__ && 199901L <= __STDC_VERSION__ \
>       && !defined __STDC_NO_VLA__)
> #  define _REGEX_NELTS(n) n
> # else
> #  define _REGEX_NELTS(n)
> # endif
> #endif
> 

.

645c681,682
<                   regmatch_t __pmatch[_Restrict_arr_],
---
>                   regmatch_t __pmatch[_Restrict_arr_
>                                       _REGEX_NELTS (__nmatch)],

.

The last hunk is the declaration of regexec(), thus:

extern int regexec (const regex_t *_Restrict_ __preg,
                    const char *_Restrict_ __String, size_t __nmatch,
                    regmatch_t __pmatch[_Restrict_arr_
                                        _REGEX_NELTS (__nmatch)],
                    int __eflags);

To fix my build, I added the following to my config.mak file on linux:

    SPARSE_FLAGS += -D__STDC_NO_VLA__

. and immediately started working on a fix to sparse! Oh wait ... :)

I did report the problem and the above workaround on the git ML [1], and
created a test in my sparse repo to demonstrate the problem, thus:

  $ git diff
  diff --git a/validation/restrict-array.c b/validation/restrict-array.c
  index 04bfdad9..86753b7d 100644
  --- a/validation/restrict-array.c
  +++ b/validation/restrict-array.c
  @@ -29,9 +29,19 @@ typedef unsigned long int size_t;
   
   extern int regexec (const regex_t *__restrict __preg,
                      const char *__restrict __string, size_t __nmatch,
  -                   regmatch_t __pmatch[__restrict_arr],
  +                   regmatch_t __pmatch[__restrict_arr __nmatch],
                      int __eflags);
   
  +static int call_regexec(const regex_t *r)
  +{
  +       char s[] = "something to search";
  +       regmatch_t pm[5];
  +
  +       if (regexec(r, s, 5, pm, 0))
  +               return 0;
  +       return 1;
  +}
  +
   /*
    * check-name: restrict array attribute
    */
  $ 

which, similarly to git, shows errors not on the declaration of the
regexec() function, but on each call site (about a dozen in git):

  $ ./sparse validation/restrict-array.c
  validation/restrict-array.c:32:56: error: undefined identifier '__nmatch'
  validation/restrict-array.c:32:56: error: bad constant expression type
  $ 

I have tried to find the time, in the last couple of days, to take a look
and find a fix for this, but I have had to admit defeat and just content
myself with noting the problem here. :(

Maybe I will find some time over the xmas break.

[1] https://lore.kernel.org/git/7498bff0-782f-8c81-5817-ed841f12dbba@ramsayjones.plus.com/

ATB,
Ramsay Jones

