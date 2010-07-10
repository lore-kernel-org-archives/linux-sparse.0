From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/2] parser: define __builtin_unreachable
Date: Sat, 10 Jul 2010 02:07:06 -0700
Message-ID: <20100710090705.GA14881@feather>
References: <AANLkTikFmeXz9og4t98jm6QcAdRa6rIeCAv3oeFnTgd8@mail.gmail.com>
 <1278751162-10053-2-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1278751162-10053-2-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: christ.li@gmail.com, jirislaby@gmail.com, Larry Finger <Larry.Finger@lwfinger.net>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Jul 10, 2010 at 10:39:22AM +0200, Jiri Slaby wrote:
> Gcc 4.5 defines
> extern void __builtin_unreachable(void);
> so, add it also to sparse.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  lib.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/lib.c b/lib.c
> index a218bfc..ae6a20c 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -740,6 +740,7 @@ void declare_builtin_functions(void)
>  	add_pre_buffer ("extern char * __builtin___strncpy_chk(char *, const char *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
>  	add_pre_buffer ("extern int __builtin___vsprintf_chk(char *, int, __SIZE_TYPE__, const char *, __builtin_va_list);\n");
>  	add_pre_buffer ("extern int __builtin___vsnprintf_chk(char *, __SIZE_TYPE__, int, __SIZE_TYPE__, const char *, __builtin_va_list ap);\n");
> +	add_pre_buffer ("extern void __builtin_unreachable(void);\n");

__builtin_unreachable has special semantics beyond just a function.
This definition will suffice to allow compilation, but
__builtin_unreachable should have the same effect in sparse that it does
in GCC: mark the point (and the remainder of the basic block) as
unreachable.  Something like the mechanism used for handling noreturn
would work here as well; declaring the function to have attribute
noreturn would probably have almost the right semantics.

- Josh Triplett
