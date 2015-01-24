From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Fri, 23 Jan 2015 17:29:58 -0800
Message-ID: <20150124012958.GB28468@thin>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
 <20150123223856.GB1489@cloud>
 <20150123235934.GA42931@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58942 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbAXBaG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Jan 2015 20:30:06 -0500
Content-Disposition: inline
In-Reply-To: <20150123235934.GA42931@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jan 24, 2015 at 12:59:35AM +0100, Luc Van Oostenryck wrote:
> Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.
> 
> This macro expands to sequential integral values starting from 0,
> and this for each top-level source file.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

counter3.c seems like a bit of an abuse of the test suite framework, but
I don't have a better suggestion.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  ident-list.h                       |  1 +
>  pre-process.c                      |  4 ++++
>  validation/preprocessor/counter1.c | 12 ++++++++++++
>  validation/preprocessor/counter2.c | 14 ++++++++++++++
>  validation/preprocessor/counter2.h |  1 +
>  validation/preprocessor/counter3.c | 13 +++++++++++++
>  6 files changed, 45 insertions(+)
>  create mode 100644 validation/preprocessor/counter1.c
>  create mode 100644 validation/preprocessor/counter2.c
>  create mode 100644 validation/preprocessor/counter2.h
>  create mode 100644 validation/preprocessor/counter3.c
> 
> diff --git a/ident-list.h b/ident-list.h
> index d5a145f8..b65b667d 100644
> --- a/ident-list.h
> +++ b/ident-list.h
> @@ -108,6 +108,7 @@ __IDENT(__TIME___ident, "__TIME__", 0);
>  __IDENT(__func___ident, "__func__", 0);
>  __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
>  __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
> +__IDENT(__COUNTER___ident, "__COUNTER__", 0);
>  
>  /* Sparse commands */
>  IDENT_RESERVED(__context__);
> diff --git a/pre-process.c b/pre-process.c
> index 1aa3d2c4..601e0f26 100644
> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -45,6 +45,7 @@
>  #include "scope.h"
>  
>  static int false_nesting = 0;
> +static int counter_macro;		// __COUNTER__ expansion
>  
>  #define INCLUDEPATHS 300
>  const char *includepath[INCLUDEPATHS+1] = {
> @@ -181,6 +182,8 @@ static int expand_one_symbol(struct token **list)
>  			time(&t);
>  		strftime(buffer, 9, "%T", localtime(&t));
>  		replace_with_string(token, buffer);
> +	} else if (token->ident == &__COUNTER___ident) {
> +		replace_with_integer(token, counter_macro++);
>  	}
>  	return 1;
>  }
> @@ -1882,6 +1885,7 @@ static void init_preprocessor(void)
>  		sym->normal = 0;
>  	}
>  
> +	counter_macro = 0;
>  }
>  
>  static void handle_preprocessor_line(struct stream *stream, struct token **line, struct token *start)
> diff --git a/validation/preprocessor/counter1.c b/validation/preprocessor/counter1.c
> new file mode 100644
> index 00000000..98187ee6
> --- /dev/null
> +++ b/validation/preprocessor/counter1.c
> @@ -0,0 +1,12 @@
> +__COUNTER__
> +__COUNTER__
> +/*
> + * check-name: __COUNTER__ #1
> + * check-command: sparse -E $file
> + *
> + * check-output-start
> +
> +0
> +1
> + * check-output-end
> + */
> diff --git a/validation/preprocessor/counter2.c b/validation/preprocessor/counter2.c
> new file mode 100644
> index 00000000..9883b682
> --- /dev/null
> +++ b/validation/preprocessor/counter2.c
> @@ -0,0 +1,14 @@
> +__FILE__ __COUNTER__
> +#include <counter2.h>
> +__FILE__ __COUNTER__
> +/*
> + * check-name: __COUNTER__ #2
> + * check-command: sparse -Ipreprocessor -E $file
> + *
> + * check-output-start
> +
> +"preprocessor/counter2.c" 0
> +"preprocessor/counter2.h" 1
> +"preprocessor/counter2.c" 2
> + * check-output-end
> + */
> diff --git a/validation/preprocessor/counter2.h b/validation/preprocessor/counter2.h
> new file mode 100644
> index 00000000..447b70ab
> --- /dev/null
> +++ b/validation/preprocessor/counter2.h
> @@ -0,0 +1 @@
> +__FILE__ __COUNTER__
> diff --git a/validation/preprocessor/counter3.c b/validation/preprocessor/counter3.c
> new file mode 100644
> index 00000000..1449b2d1
> --- /dev/null
> +++ b/validation/preprocessor/counter3.c
> @@ -0,0 +1,13 @@
> +/*
> + * check-name: __COUNTER__ #3
> + * check-command: sparse -Ipreprocessor -E preprocessor/counter1.c preprocessor/counter2.c
> + *
> + * check-output-start
> +
> +0
> +1
> +"preprocessor/counter2.c" 0
> +"preprocessor/counter2.h" 1
> +"preprocessor/counter2.c" 2
> + * check-output-end
> + */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
