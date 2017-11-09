From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 27/37] build: use a dot file name instead of local.mk:
 .sparse.mk
Date: Thu, 9 Nov 2017 14:56:44 +0000
Message-ID: <331e1528-dc30-ecd9-38ea-0b5c03b99c1b@ramsayjones.plus.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
 <20171109064648.15379-28-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:38347 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752732AbdKIO4s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 09:56:48 -0500
In-Reply-To: <20171109064648.15379-28-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>



On 09/11/17 06:46, Luc Van Oostenryck wrote:
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  .gitignore | 2 +-
>  Makefile   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index ab976e76b..35b4d0248 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -36,7 +36,7 @@ patches
>  series
>  
>  # local makefile
> -local.mk
> +.sparse.mk
>  
>  # cscope and Qt files
>  cscope.out
> diff --git a/Makefile b/Makefile
> index 4f6ab108c..afc1efe98 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,11 +21,11 @@ MANDIR=$(PREFIX)/share/man
>  MAN1DIR=$(MANDIR)/man1
>  
>  # Allow users to override build settings without dirtying their trees
> -# For debugging, put this in local.mk:
> +# For debugging, put this in .sparse.mk:
>  #
>  #     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
>  #
> --include local.mk
> +-include .sparse.mk
>  ########################################################################
>  
>  
> 

I don't see any reason to make this change. The commit message
does not make a very convincing argument! :-D

ATB,
Ramsay Jones

