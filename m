From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/3 v4] Add Wall_off switch to disable errors and warnings
Date: Tue, 5 Jan 2016 02:19:59 +0100
Message-ID: <20160105011958.GA12545@macpro.local>
References: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <1438619759-14879-1-git-send-email-tcamuso@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34370 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbcAEBUE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jan 2016 20:20:04 -0500
Received: by mail-wm0-f53.google.com with SMTP id u188so5823807wmu.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Jan 2016 17:20:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1438619759-14879-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: sam@ravnborg.org, linux-sparse@vger.kernel.org, josh@joshtriplett.org, sparse@chrisli.org

On Mon, Aug 03, 2015 at 12:35:59PM -0400, Tony Camuso wrote:
> Disable all error reporting. Useful when semantic parsing checks are
> being done elsewhere or all you need is a tokenizer.
> 
> Signed-off-by: Tony Camuso <tcamuso@redhat.com>
> ---
>  lib.c | 27 +++++++++++++++++++++++----
>  lib.h |  1 +
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/lib.c b/lib.c
> index 8dc5bcf..08f6a6b 100644
> --- a/lib.c
> +++ b/lib.c

...

> @@ -130,6 +135,12 @@ void info(struct position pos, const char * fmt, ...)
>  static void do_error(struct position pos, const char * fmt, va_list args)
>  {
>  	static int errors = 0;
> +
> +	if (Wall_off) {
> +		max_warnings = 0;
> +		return;
> +	}
> +

Is this really needed?
The same check in do_warn should be enough to quiet all messages, isn't it?


> @@ -479,6 +491,13 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
>  	char *p = arg + 1;
>  	unsigned i;
>  
> +	if (!strcmp(p, "all_off")) {
> +		for (i = 0; i < n; i++)
> +			*warnings[i].flag = WARNING_FORCE_OFF;
> +		Wall_off = 1;
> +		return NULL;
> +	}
> +

Can't you simply set max_warnings to 0 already here
instead of doing it in do_warn()?

> @@ -127,6 +127,7 @@ extern int Wtypesign;
>  extern int Wundef;
>  extern int Wuninitialized;
>  extern int Wvla;
> +extern int Wall_off;

I think it should be better to use a much more explicit name,
something like "ignore_all_warnings" for example.

Also it would be nice to document this new option in the man page.


Regards,
Luc
