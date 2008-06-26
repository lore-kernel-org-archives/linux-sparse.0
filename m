From: "Chris Li" <christ.li@gmail.com>
Subject: Re: Pointer arithmetic error
Date: Thu, 26 Jun 2008 16:51:25 -0700
Message-ID: <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
References: <486428D7.8080603@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:46038 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYFZXvb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jun 2008 19:51:31 -0400
Received: by yw-out-2324.google.com with SMTP id 9so92492ywe.1
        for <linux-sparse@vger.kernel.org>; Thu, 26 Jun 2008 16:51:26 -0700 (PDT)
In-Reply-To: <486428D7.8080603@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jun 26, 2008 at 4:40 PM, David Given <dg@cowlark.com> wrote:
>        /* Get the size of whatever the pointer points to */
>        multiply = base->bit_size >> 3;
>
> This divides the bit size by 8 to get the size in bytes. However, this
> doesn't take into account that bits_in_char might not be 8. I think this
> should actually be:
>
>        /* Get the size of whatever the pointer points to */
>        multiply = base->bit_size / bits_in_char;

I don't think so. The offset part of the ptr_add op is mean to be the
absolute offset, not how many element of the pointer index. In other
words, it is how many address number it need to add.

Chris
