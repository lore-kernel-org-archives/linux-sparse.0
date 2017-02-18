From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/5] replace test for c99 for-loop initializers
Date: Sat, 18 Feb 2017 22:37:36 +0000
Message-ID: <12926366-f68d-460a-a181-cd30303631d5@ramsayjones.plus.com>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
 <20170218203048.22276-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:57660 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdBRWnb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Feb 2017 17:43:31 -0500
In-Reply-To: <20170218203048.22276-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>



On 18/02/17 20:30, Luc Van Oostenryck wrote:
> The existing test is an indirect test, using a warning
> about context imbalance to show that some part of code
> was discarded.
> 
> Now that we have the minimal tools to test the output of
> test-linearize, use them to replace the test by a direct one.

Hmm, it may be a more direct test, but it is not clear
just what is being tested (or indeed how it is being tested).

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/c99-for-loop.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/validation/c99-for-loop.c b/validation/c99-for-loop.c
> index 42246c513..427fde268 100644
> --- a/validation/c99-for-loop.c
> +++ b/validation/c99-for-loop.c
> @@ -1,33 +1,21 @@
> -int op(int);
> -
> -static int good(void)
> +int c99(void);
> +int c99(void)
>  {
> -	__context__(1);
> -	for (int i = 0; i < 10; i++) {
> -		if (!op(i)) {
> -			__context__(-1);
> -			return 0;
> -		}
> -	}
> -	__context__(-1);
> -	return 1;
> -}
> +	int r = -1;
>  
> -static int bad(void)
> -{
> -	__context__(1);
>  	for (int i = 0; i < 10; i++) {
> -		if (!op(i)) {
> -			__context__(-1);
> -			return 0;
> -		}
> +		r = i;
>  	}
> -	return 1;
> +
> +	return r;
>  }
> +
>  /*
>   * check-name: C99 for loop variable declaration
> + * check-command: test-linearize $file
>   *
> - * check-error-start
> -c99-for-loop.c:16:12: warning: context imbalance in 'bad' - different lock contexts for basic block
> - * check-error-end
> + * check-output-ignore
> + * check-output-contains: phisrc\\.
> + * check-output-contains: phi\\.
> + * check-output-contains: add\\.
>   */
> 

After applying this patch, I edited validation/c99-for-loop.c
like so:

    $ git diff
    diff --git a/validation/c99-for-loop.c b/validation/c99-for-loop.c
    index 427fde2..6b24fa8 100644
    --- a/validation/c99-for-loop.c
    +++ b/validation/c99-for-loop.c
    @@ -2,8 +2,9 @@ int c99(void);
     int c99(void)
     {
            int r = -1;
    +       int i;
 
    -       for (int i = 0; i < 10; i++) {
    +       for (i = 0; i < 10; i++) {
                    r = i;
            }
 
    $ 

This modified test still passes (indeed the output is identical).
:-P

ATB,
Ramsay Jones


