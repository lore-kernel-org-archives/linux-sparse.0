From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Make -Werror turn warnigns into errors
Date: Wed, 24 Sep 2014 23:24:04 +0800
Message-ID: <CANeU7QnRFxZ+OV5G2W3tC+tBnYNNcQsH_YEB=cyHmAfmfYc1PQ@mail.gmail.com>
References: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:64943 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaIXPYG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 11:24:06 -0400
Received: by mail-wg0-f52.google.com with SMTP id n12so4650219wgh.23
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 08:24:04 -0700 (PDT)
In-Reply-To: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 4, 2014 at 2:54 AM, Thomas Graf <tgraf@suug.ch> wrote:
> Make sparse fail and return an error code if a warning is encountered
> and -Werror is specified or a hard error is found. This allows to use
> sparse in automated build systems to more easily catch new sparse
> warnings.

Most of the change looks fine.

>
> Due to sparse now returning non zero on failure, the test cases
> triggering a error have to be adapated to check for the non zero return
> value.
>
> diff --git a/validation/__func__.c b/validation/__func__.c
> index 65ce928..6003a86 100644
> --- a/validation/__func__.c
> +++ b/validation/__func__.c
> @@ -12,4 +12,5 @@ static void f(void)
>  __func__.c:5:29: error: Expected ; at end of declaration
>  __func__.c:5:29: error: got __func__
>   * check-error-end
> + * check-exit-value: 1
>   */

In stead of patching each test case file. How about teach the
test-suilte to be smarter? The test-suilte should change the default
return value to none zero if there is none empty "check-error-start" and
"check-error-end" section. In other words, if there is expected
error output, we already guess the returns status is error.
The test case can still use "check-exit-value" to overwrite the default
value.

I expect that can save most of the patching to test case file.

Thanks

Chris
