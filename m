From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/3] validation: dubious bitwise operations with nots
Date: Mon, 9 Jun 2014 06:36:20 -0700
Message-ID: <20140609133620.GC11986@thin>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402315082-14102-2-git-send-email-phil@dovecot.fi>
 <1402315082-14102-3-git-send-email-phil@dovecot.fi>
 <1402315082-14102-4-git-send-email-phil@dovecot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48524 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbaFINg2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jun 2014 09:36:28 -0400
Content-Disposition: inline
In-Reply-To: <1402315082-14102-4-git-send-email-phil@dovecot.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Phil Carmody <phil@dovecot.fi>
Cc: sparse@chrisli.org, linux-sparse@vger.kernel.org

On Mon, Jun 09, 2014 at 02:58:02PM +0300, Phil Carmody wrote:
> Add some bitwise not tests.
> 
> Signed-off-by: Phil Carmody <phil@dovecot.fi>
> ---
>  validation/dubious-bitwise-with-not.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/validation/dubious-bitwise-with-not.c b/validation/dubious-bitwise-with-not.c
> index c48bcae..1cfd5c5 100644
> --- a/validation/dubious-bitwise-with-not.c
> +++ b/validation/dubious-bitwise-with-not.c
> @@ -10,8 +10,32 @@ static unsigned int ok5  = !1 && !2;
>  static unsigned int bad5 = !1 &  !2;
>  static unsigned int ok6  = !1 || !2;
>  static unsigned int bad6 = !1 |  !2;
> +static unsigned long long ok7a  = 0x100000001ull & ~1;
> +static unsigned long long ok7b  = 0x100000001ull & ~1ull;
> +static unsigned long long bad7  = 0x100000001ull & ~1u;
> +static unsigned long long ok8a  = ~1    & 0x100000001ull;
> +static unsigned long long ok8b  = ~1ull & 0x100000001ull;
> +static unsigned long long bad8  = ~1u   & 0x100000001ull;
> +static unsigned long long ok9a  = 0x100000001ull | ~1;
> +static unsigned long long ok9b  = 0x100000001ull | ~1ull;
> +static unsigned long long bad9  = 0x100000001ull | ~1u;
> +static unsigned long long ok10a = ~1    | 0x100000001ull;
> +static unsigned long long ok10b = ~1ull | 0x100000001ull;
> +static unsigned long long bad10 = ~1u   | 0x100000001ull;
> +static unsigned long long ok11a = 0x100000001ull + ~1;
> +static unsigned long long ok11b = 0x100000001ull + ~1ull;
> +static unsigned long long bad11 = 0x100000001ull + ~1u;
> +static unsigned long long ok12a = ~1    + 0x100000001ull;
> +static unsigned long long ok12b = ~1ull + 0x100000001ull;
> +static unsigned long long bad12 = ~1u   + 0x100000001ull;
> +static unsigned long long ok13a = 0x100000001ull - ~1;
> +static unsigned long long ok13b = 0x100000001ull - ~1ull;
> +static unsigned long long bad13 = 0x100000001ull - ~1u;
> +static unsigned long long ok14a = ~1    - 0x100000001ull;
> +static unsigned long long ok14b = ~1ull - 0x100000001ull;
> +static unsigned long long bad14 = ~1u   - 0x100000001ull;
>  /*
> - * check-name: Dubious bitwise operation on !x
> + * check-name: Dubious bitwise operations with nots

For clarity, I'd suggest writing this as "with !x or ~x".

>   *
>   * check-error-start
>  dubious-bitwise-with-not.c:2:31: warning: dubious: !x & y
> @@ -20,5 +44,13 @@ dubious-bitwise-with-not.c:6:31: warning: dubious: x & !y
>  dubious-bitwise-with-not.c:8:31: warning: dubious: x | !y
>  dubious-bitwise-with-not.c:10:31: warning: dubious: !x & !y
>  dubious-bitwise-with-not.c:12:31: warning: dubious: !x | !y
> +dubious-bitwise-with-not.c:15:50: warning: dubious: x & ~y
> +dubious-bitwise-with-not.c:18:41: warning: dubious: ~x & y
> +dubious-bitwise-with-not.c:21:50: warning: dubious: x | ~y
> +dubious-bitwise-with-not.c:24:41: warning: dubious: ~x | y
> +dubious-bitwise-with-not.c:27:50: warning: dubious: x + ~y
> +dubious-bitwise-with-not.c:30:41: warning: dubious: ~x + y
> +dubious-bitwise-with-not.c:33:50: warning: dubious: x - ~y
> +dubious-bitwise-with-not.c:36:41: warning: dubious: ~x - y
>   * check-error-end
>   */
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
