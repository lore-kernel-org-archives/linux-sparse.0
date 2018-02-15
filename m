From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] disable sparse warnings about unknown attributes
Date: Thu, 15 Feb 2018 15:21:14 -0800
Message-ID: <c215cf31-ba19-49ff-3da9-268e64ea1ba0@infradead.org>
References: <20180215210750.28813-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20180215210750.28813-1-luc.vanoostenryck@gmail.com>
Content-Language: en-US
Sender: linux-kbuild-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On 02/15/2018 01:07 PM, Luc Van Oostenryck wrote:
> Currently, sparse issues warnings on code using an attribute
> it doesn't know about.
> 
> One of the problem with this is that these warnings have no
> value for the developer, it's just noise for him. At best these
> warnings tell something about some deficiencies of sparse itself
> but not about a potential problem with code analyzed.
> 
> A second problem with this is that sparse release are, alas,
> less frequent than new attributes are added to GCC.
> 
> So, avoid the noise by asking sparse to not warn about
> attributes it doesn't know about.
> 
> Reference: https://marc.info/?l=linux-sparse&m=151871600016790
> Reference: https://marc.info/?l=linux-sparse&m=151871725417322
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 79ad2bfa2..8d9a7374c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -388,7 +388,7 @@ PYTHON		= python
>  CHECK		= sparse
>  
>  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
> -		  -Wbitwise -Wno-return-void $(CF)
> +		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
>  NOSTDINC_FLAGS  =
>  CFLAGS_MODULE   =
>  AFLAGS_MODULE   =
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks,
-- 
~Randy
