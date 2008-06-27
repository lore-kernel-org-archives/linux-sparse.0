From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 02:00:29 -0700
Message-ID: <70318cbf0806270200l27aef92ctbc3fbd4f3cbf9f45@mail.gmail.com>
References: <486428D7.8080603@cowlark.com>
	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
	 <48643191.307@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:46813 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbYF0JAd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 05:00:33 -0400
Received: by yw-out-2324.google.com with SMTP id 9so169401ywe.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 02:00:29 -0700 (PDT)
In-Reply-To: <48643191.307@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jun 26, 2008 at 5:17 PM, David Given <dg@cowlark.com> wrote:

> Hmm. True. But even so, it's still not right on my system, which doesn't
> use 8-bit bytes. (It's word addressable where each word can contain any
> value, so sizeof(int) == sizeof(double) == sizeof(char) == 1.)

Ah, I see.  I was thinking some thing else.
What platform exactly is that?

> Should there, then, be another symbol to define the number of bits in a
> byte, distinct from the number of bits in a char?

Byte need to big enough to hold the char. Using bits_in_byte is better.
There might be other place in sparse assume byte is 8 bits.

Chris
