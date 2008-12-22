From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Casting away noderef and address spaces?
Date: Mon, 22 Dec 2008 12:06:03 -0800
Message-ID: <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
References: <200812221606.13910.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:15274 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbYLVUGE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 15:06:04 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2055683rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 12:06:03 -0800 (PST)
In-Reply-To: <200812221606.13910.rusty@rustcorp.com.au>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-sparse@vger.kernel.org

On Sun, Dec 21, 2008 at 9:36 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> #define convert(v) \
>        (*(__attribute__((address_space(0), force)) typeof(&v))(v))
>
Am I reading it right? You are trying to dereferenc a type instead of a pointer?

I don't think you can do that with sparse.

Are you trying to declare the per_cpu as the third address space
and force every usage of the per_cpu variable going through the conversion?

Chris
