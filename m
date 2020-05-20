From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 01/28] misc: fix testcase typeof-safe
Date: Wed, 20 May 2020 01:33:07 +0100
Message-ID: <422723ea-00aa-ee89-72aa-f4dddbd8da06@ramsayjones.plus.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:60558 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgETAdL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:33:11 -0400
In-Reply-To: <20200519005728.84594-2-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>



On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> This testcase was marked as known-to-fail but it was
> simply the expected error messages that were missing.
> 
> So, slightly reorganize the test a little bit, add the
> expected messages and remove the 'known-to-fail' tag.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/typeof-safe.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/validation/typeof-safe.c b/validation/typeof-safe.c
> index 614863fba381..508bd39204c5 100644
> --- a/validation/typeof-safe.c
> +++ b/validation/typeof-safe.c
> @@ -2,16 +2,24 @@
>  
>  static void test_safe(void)
>  {
> -	int __safe obj, *ptr;
> -	typeof(obj) var = obj;
> -	typeof(ptr) ptr2 = ptr;
> +	int obj;
> +	int __safe *ptr;
> +
> +	int __safe *ptr2 = ptr;
> +	typeof(ptr) ptr3 = ptr;
>  	typeof(*ptr) var2 = obj;
> -	typeof(*ptr) *ptr3 = ptr;
> -	typeof(obj) *ptr4 = ptr;
> +	int __safe  var3 = obj;
> +	int *ptr4 = &obj;
> +	int *ptr4 = ptr;		// KO

ptr4 declared twice - and sparse didn't complain?

ATB,
Ramsay Jones

> +
> +	typeof(*ptr) sobj;
> +	typeof(&sobj) ptr5 = &obj;
> +	typeof(&sobj) ptr6 = ptr;	// KO
> +
>  	obj = obj;
>  	ptr = ptr;
> -	ptr = &obj;
>  	obj = *ptr;
> +	ptr = (int __safe *) &obj;
>  }
>  
>  /*
> @@ -19,5 +27,11 @@ static void test_safe(void)
>   * check-known-to-fail
>   *
>   * check-error-start
> +typeof-safe.c:13:21: warning: incorrect type in initializer (different modifiers)
> +typeof-safe.c:13:21:    expected int *ptr4
> +typeof-safe.c:13:21:    got int [safe] *ptr
> +typeof-safe.c:17:30: warning: incorrect type in initializer (different modifiers)
> +typeof-safe.c:17:30:    expected int *ptr6
> +typeof-safe.c:17:30:    got int [safe] *ptr
>   * check-error-end
>   */
> 
