Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654E15AE
	for <linux-sparse@vger.kernel.org>; Thu, 21 Dec 2023 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="VLW+6BJh"
Received: from [10.0.2.15] ([146.198.40.91])
	by smtp with ESMTPA
	id G885rbeq7h1xeG886reY4k; Thu, 21 Dec 2023 01:45:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1703123142; bh=SZLhglo32U5wtIeowSJN94MTSa7dFvQ+e5blNjZlFMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VLW+6BJhoRtkoVpFuy0nZiFul2fcRAaLT7RVKXiU0C5mYBRSS7ox3yRN3vMtIpO3i
	 jgKTJzSoy/zONcKE5KP4mqSO7OuM98U+G7ECGsDEzQb0WHob7QXnv+YpSPOKqKU8Sv
	 ylT7VgGfdZUl3iBUOnRNCuPB4g1rvIYz4QJ3mkX/cJgCU2tQsLHqAY5IzVFi/njFOK
	 luJLlzLMlNclNUtX3gFGOAsnVJRKOIHHuUbkA5w0DVrXtpC7uCTPyFoUb9XYldi0AD
	 fG2XS96Fg2dv/bUx2egLGmLc+N2S/cM6/kC4p20KVXtEDwAYAxa1svmjW6BVpCk9n6
	 2tmtKRB1i55Bg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=C/z6dCD+ c=1 sm=1 tr=0 ts=658398c6
 a=KA9ncW3+NP+rNtcBcdh9kA==:117 a=KA9ncW3+NP+rNtcBcdh9kA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=bXkE6LXqEXhjat7BDCEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <24cb6194-d04d-4c80-bd95-4f7356667884@ramsayjones.plus.com>
Date: Thu, 21 Dec 2023 01:45:41 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sparse regex error
To: Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Sparse Mailing-list <linux-sparse@vger.kernel.org>
References: <6f853a6b-9ac3-4bfd-a968-89d43fbcce2a@ramsayjones.plus.com>
 <uug4xslokvlxr6z24q52z4pt7nrtiimbzunz2gz3kpilk4kxts@7jljsksi6baq>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <uug4xslokvlxr6z24q52z4pt7nrtiimbzunz2gz3kpilk4kxts@7jljsksi6baq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFPG9Z/RGBl8G2iMSy/2CsDzZTyk28gzy0H/nL0rb6tQTfX0H7YUyQDeSUtv7aRbsSRUsDGgJhdbRvDeGc+mAXEyctCWgYoWP7ujhdFAPSiPLAFsKlJ5
 9bjqmgKjEhb+8jt9SYpgPbmeTBLbTdH1lDr1HoGbC656JQ1cad8tsqpRfh90FQOVKvtMxXGihly8cErMzvX2r/vTklB5Tyxjjpw=



On 20/12/2023 23:13, Luc Van Oostenryck wrote:
[snip] 
> The following patch is a bit ugly but should solve the problem here above.
> It's hasn't had much testing, only the testsuite.
> 
> Cheers,
> -- Luc
> 
> 
>>From 2d1feff1551a97fdfd1149f4772331c540e638c9 Mon Sep 17 00:00:00 2001
> From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Date: Wed, 20 Dec 2023 22:00:05 +0100
> Subject: [PATCH] handle protoype scope
> 

Hi Luc,

This looks good and _much_ better than my initial attempt! ;)

I tried your patch and everything looks good on the sparse repo.
On Git, however, things didn't go quite so well, thus:

  $ make V=1 sparse >ssp-out 2>&1
  $ tail -4 ssp-out
  >add-patch.sp
  add-patch.c: note: in included file (through git-compat-util.h):
  /usr/include/regex.h:682:41: error: Variable length array is used.
  make: *** [Makefile:3234: add-patch.sp] Error 1
  $ 

I think this is caused by -Wvla, which git passes to gcc, along with
sparse (perhaps) not supporting a GCC #pragma; just after the _REGEX_NELTS
definition in the header file we find:

  #if defined __GNUC__ && 4 < __GNUC__ + (6 <= __GNUC_MINOR__)
  # pragma GCC diagnostic push
  # pragma GCC diagnostic ignored "-Wvla"
  #endif

But I haven't had time to think about this too deeply. It's nearly 2am
and I need to get some sleep - I just wanted to report this ASAP.

Thanks for the patch.

ATB,
Ramsay Jones

