From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 25/28] bad-goto: check declaration of label expressions
Date: Wed, 20 May 2020 01:56:27 +0100
Message-ID: <f75a85c4-c5c1-baab-7c8e-6bf14a925764@ramsayjones.plus.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-26-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:33458 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETA4a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:56:30 -0400
In-Reply-To: <20200519005728.84594-26-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>



On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> Issue an error when taking the address of an undeclared label
> and mark the mark the function as improper for linearization

s/mark the mark the/mark the/

ATB,
Ramsay Jones

> since the resulting IR would be invalid.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  evaluate.c                            | 1 +
>  validation/label-scope-cgoto.c        | 1 -
>  validation/linear/label-scope-cgoto.c | 1 -
>  3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index b272e3f642b2..63d75d9031d1 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -3344,6 +3344,7 @@ struct symbol *evaluate_expression(struct expression *expr)
>  
>  	case EXPR_LABEL:
>  		expr->ctype = &ptr_ctype;
> +		check_label_declaration(expr->pos, expr->label_symbol);
>  		return &ptr_ctype;
>  
>  	case EXPR_TYPE:
> diff --git a/validation/label-scope-cgoto.c b/validation/label-scope-cgoto.c
> index c5d278d3d654..1edb9948d8cf 100644
> --- a/validation/label-scope-cgoto.c
> +++ b/validation/label-scope-cgoto.c
> @@ -65,7 +65,6 @@ l:		 1;
>  /*
>   * check-name: label-scope-cgoto
>   * check-command: sparse -Wno-decl $file
> - * check-known-to-fail
>   *
>   * check-error-start
>  label-scope-cgoto.c:12:19: error: label 'l' used outside statement expression
> diff --git a/validation/linear/label-scope-cgoto.c b/validation/linear/label-scope-cgoto.c
> index 592f1ce4f664..0eba05aea3c7 100644
> --- a/validation/linear/label-scope-cgoto.c
> +++ b/validation/linear/label-scope-cgoto.c
> @@ -3,7 +3,6 @@
>  /*
>   * check-name: linear/label-scope-cgoto
>   * check-command: test-linearize -Wno-decl -I. $file
> - * check-known-to-fail
>   *
>   * check-error-ignore
>   * check-output-ignore
> 
