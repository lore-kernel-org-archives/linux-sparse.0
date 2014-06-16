From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Staging/comedi: Fixes static analysis warning raised by
 sparse
Date: Mon, 16 Jun 2014 10:40:19 +0300
Message-ID: <20140616074019.GL5015@mwanda>
References: <53965E53.5080504@gmail.com> <20140610054741.GE5500@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9AE6A@P3PWEX4MB008.ex4.secureserver.net>
 <20140611065612.GQ5015@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
 <20140611212425.GW5015@mwanda> <20140611214529.GB16940@cloud>
 <20140615193227.GA24515@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20140615193227.GA24515@ravnborg.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, linux-sparse@vger.kernel.org, josh@joshtriplett.org, "Marcos A. Di Pietro" <marcosadp@gmail.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Jun 15, 2014 at 09:32:27PM +0200, Sam Ravnborg wrote:
> diff --git a/expand.c b/expand.c
> index 0f6720c..4a96de4 100644
> --- a/expand.c
> +++ b/expand.c
> @@ -187,7 +187,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
>  		return 0;
>  	r = right->value;
>  	if (expr->op == SPECIAL_LEFTSHIFT || expr->op == SPECIAL_RIGHTSHIFT) {
> -		if (r >= ctype->bit_size) {
> +		if (expr->flags & Int_const_expr && r >= ctype->bit_size) {

Thanks!  I had no idea how to start writing a fix for this, but the test
should be:
		if (expr->right->flags & Int_const_expr

Otherwise both sides of the shift have to be const.

>  			if (conservative)
>  				return 0;
>  			r = check_shift_count(expr, ctype, r);
> 

regards,
dan carpenter
