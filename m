From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Wed, 29 Jul 2015 19:55:02 -0700
Message-ID: <20150730025502.GA1692@x>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
 <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39878 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbG3CzM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Jul 2015 22:55:12 -0400
Content-Disposition: inline
In-Reply-To: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: sparse@chrisli.org, linux-sparse@vger.kernel.org

On Wed, Jul 29, 2015 at 08:26:41PM -0400, Tony Camuso wrote:
> Allows building sparse to avert reporting semantic problems, e.g.
> using sparse as a tokenizer to create a graph of KABI symbols and
> their dependencies.
> 
> Signed-off-by: Tony Camuso <tcamuso@redhat.com>

This doesn't seem like something that should be determined at compile
time.  Ideally, this should be determined at runtime.

>  lib.c   | 21 +++++++++++++++++++++
>  parse.c | 12 ++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/lib.c b/lib.c
> index 8dc5bcf..cb10bce 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -48,6 +48,13 @@
>  int verbose, optimize, optimize_size, preprocessing;
>  int die_if_error = 0;
>  
> +#ifdef NOWARN
> +#pragma message "Built with NOWARN"
> +#endif
> +#ifdef NOERR
> +#pragma message "Built with NOERR"
> +#endif
> +
>  #ifndef __GNUC__
>  # define __GNUC__ 2
>  # define __GNUC_MINOR__ 95
> @@ -103,6 +110,9 @@ unsigned int hexval(unsigned int c)
>  
>  static void do_warn(const char *type, struct position pos, const char * fmt, va_list args)
>  {
> +#ifdef NOWARN
> +	return;
> +#else
>  	static char buffer[512];
>  	const char *name;
>  
> @@ -111,9 +121,12 @@ static void do_warn(const char *type, struct position pos, const char * fmt, va_
>  		
>  	fprintf(stderr, "%s:%d:%d: %s%s\n",
>  		name, pos.line, pos.pos, type, buffer);
> +#endif
>  }
>  
> +#ifndef NOWARN
>  static int max_warnings = 100;
> +#endif
>  static int show_info = 1;
>  
>  void info(struct position pos, const char * fmt, ...)
> @@ -129,6 +142,9 @@ void info(struct position pos, const char * fmt, ...)
>  
>  static void do_error(struct position pos, const char * fmt, va_list args)
>  {
> +#ifdef NOERR
> +	return;
> +#else
>  	static int errors = 0;
>          die_if_error = 1;
>  	show_info = 1;
> @@ -145,10 +161,14 @@ static void do_error(struct position pos, const char * fmt, va_list args)
>  
>  	do_warn("error: ", pos, fmt, args);
>  	errors++;
> +#endif
>  }	
>  
>  void warning(struct position pos, const char * fmt, ...)
>  {
> +#ifdef NOWARN
> +	return;
> +#else
>  	va_list args;
>  
>  	if (Wsparse_error) {
> @@ -171,6 +191,7 @@ void warning(struct position pos, const char * fmt, ...)
>  	va_start(args, fmt);
>  	do_warn("warning: ", pos, fmt, args);
>  	va_end(args);
> +#endif
>  }
>  
>  void sparse_error(struct position pos, const char * fmt, ...)
> diff --git a/parse.c b/parse.c
> index 02275d8..f773fe8 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -44,6 +44,13 @@
>  #include "expression.h"
>  #include "target.h"
>  
> +#ifdef NOWARN
> +#pragma message "Built with NOWARN"
> +#endif
> +#ifdef NOERR
> +#pragma message "Built with NOERR"
> +#endif
> +
>  static struct symbol_list **function_symbol_list;
>  struct symbol_list *function_computed_target_list;
>  struct statement_list *function_computed_goto_list;
> @@ -2746,8 +2753,13 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  
>  	/* Just a type declaration? */
>  	if (!ident) {
> +
> +#if defined NOWARN || defined NOERR
> +		return token->next;
> +#else
>  		warning(token->pos, "missing identifier in declaration");
>  		return expect(token, ';', "at the end of type declaration");
> +#endif
>  	}
>  
>  	/* type define declaration? */
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
