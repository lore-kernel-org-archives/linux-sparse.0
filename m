From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH RFC] sparse, llvm: simplify function generation
Date: Sat, 18 May 2013 10:36:27 +0300
Message-ID: <CAOJsxLGWnOTLNX6HR3tymU6PQ7jsdEjimny1NNzi8Gzesd0ckQ@mail.gmail.com>
References: <1368774359-5475-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:65149 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab3ERHg2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 03:36:28 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so969211wgg.4
        for <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 00:36:27 -0700 (PDT)
In-Reply-To: <1368774359-5475-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, May 17, 2013 at 10:05 AM, Xi Wang <xi.wang@gmail.com> wrote:
> Remove repeated code, such as get_func_type() vs sym_func_type(),
> pseudo_type() vs symbol_type().
>
> Fix generating variadic functions.
>
> Add a test case using printf().
>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

Applied, thanks!
