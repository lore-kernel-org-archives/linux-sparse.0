Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840329B8EF
	for <linux-sparse@vger.kernel.org>; Sat, 27 Dec 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766851093; cv=none; b=TyYlBktjeLj9tOFYgc5jI1y35yz+JFrijfG60ZEp4P4iPUGzTJqeso04UK8FfDo/ko3nYtE95Np/spwNhY5/OfSGCuFaVcZJCUagnVmVEOHsZEqkmgMu5PormoKq7FdhOoFTKjmzX0bHDmF3uX+XMIoGIk+rLB8CHKbCbatxqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766851093; c=relaxed/simple;
	bh=otnVkfSYraKd+S0uhp1c/HjW6jU9ayzcP7I7l2Wmjc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8r4c7y4rFCj0WKlOYaiFVdPZwbqe9FU+QIjFApUN7qwZbSwwmP3wYgDLTBpn69/XEL5lqKT/QUc2agfH2TcB2ERNItEs68xKRdRLjpJYuRV9lNCB3iqVn1bWYLURtxU9oN/mSdFt/AS8rLe86Tw0U14OfNlyxgw3YHOIuLn+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyrGmUU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyrGmUU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE592C4CEF1;
	Sat, 27 Dec 2025 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766851093;
	bh=otnVkfSYraKd+S0uhp1c/HjW6jU9ayzcP7I7l2Wmjc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyrGmUU1WSkn7yQ5TB62S6v0vF9wu3Sjlatu2kgrUtmHWSpxUmbwXneps5CeZiRiS
	 lDmxXoSaJbyZVrImDaslGBWmJou0nN2skBMquClKDLCEMxTTu4j1wdujr4BawsC2DL
	 dCqj30o97yE94g605BkK+X3d3jCjtSBcSXJw8ZafpuqGTvfs0Buu6UP0nbGyMGgKfB
	 bc6/9yG8p2HeQjpT5hlEwdp39g7wL9qq2tiBz25iP52mTL7iIAOZeCIgf/ZK0OBq7+
	 OJSDJfdef72ONQu38Yk6DHoHOKbtYPzyUjnibWzg86Mwzm4Fn3FCu8Agx+8BUYlxVe
	 LpS/k0UviE3vA==
Date: Sat, 27 Dec 2025 16:58:08 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/2] sparse/semind: robustify parse_cmdline_add()
Message-ID: <aVACEIgAFSJgUJYj@example.org>
References: <aU6cXFyfwtD9GMYa@redhat.com>
 <aU6ceAt7RhlwGJ9-@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aU6ceAt7RhlwGJ9-@redhat.com>

On Fri, Dec 26, 2025 at 03:32:24PM +0100, Oleg Nesterov wrote:
> "semind add -ftabstop=8 ..." works as expected, but (for example)
> "semind add --param=dissect-show-all-symbols ..." doesn't, this
> arg is not passed to sparse_initialize().
> 
> Because in the latter case getopt_long() increments optind when it
> sees --param=dissect-show-all-symbols. I have no idea if getopt_long()
> is correct or not, but lets change parse_cmdline_add() so that it doesn't
> depend on getopt_long()'s behaviour.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Hm. This behavior seems very strange to me. I couldn't find an explanation
for it in getopt_long(3) man page. But I tried this sample with glibc and
musl, and the behavior was the same and does not depend on POSIXLY_CORRECT

  #include <stdio.h>
  #include <getopt.h>
  
  int main(int argc, char **argv)
  {
          char c;
          opterr = 0;
  
          while ((c = getopt_long(argc, argv, "", NULL, NULL)) != -1) {
                  if (c != '?')
                          printf("unexpected known option: %c\n", c);
                  break;
          }
          printf("optind=%d\n", optind);
          return 0;
  }

Here are the results from both libc:

  for o in --f "--f f" -f -ff "-f f"; do printf '%s\t' "args='$o'"; ./z-musl $o; done
  args='--f'	optind=1
  args='--f f'	optind=1
  args='-f'	optind=2
  args='-ff'	optind=1
  args='-f f'	optind=2

So it seems that this is common behavior for different libc's.
Thank you so much for finding this and fixing it!

Acked-by: Alexey Gladkov <legion@kernel.org>

> ---
>  semind.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/semind.c b/semind.c
> index fa084e04..e9708444 100644
> --- a/semind.c
> +++ b/semind.c
> @@ -298,7 +298,7 @@ static void parse_cmdline_add(int argc, char **argv)
>  		{ "help", no_argument, NULL, 'h' },
>  		{ NULL }
>  	};
> -	int c;
> +	int parsed = optind, c;
>  
>  	opterr = 0;
>  
> @@ -315,6 +315,7 @@ static void parse_cmdline_add(int argc, char **argv)
>  			case '?':
>  				goto done;
>  		}
> +		parsed = optind;
>  	}
>  done:
>  	if (optind == argc) {
> @@ -327,9 +328,8 @@ done:
>  	dissect_show_all_symbols = 1;
>  
>  	// step back since sparse_initialize will ignore argv[0].
> -	optind--;
> -
> -	sparse_initialize(argc - optind, argv + optind, &semind_filelist);
> +	parsed--;
> +	sparse_initialize(argc - parsed, argv + parsed, &semind_filelist);
>  }
>  
>  static void parse_cmdline_rm(int argc, char **argv)
> -- 
> 2.52.0
> 
> 

-- 
Rgrds, legion

