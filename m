From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] kmemcheck: fix sparse warning
Date: Wed, 8 Jul 2009 13:28:49 -0700
Message-ID: <70318cbf0907081328m2542d999l7865add3145cd48@mail.gmail.com>
References: <1246873983.20908.0.camel@johannes.local>
	 <19f34abd0907081228p541d1cdao85f37aaa479fcfc5@mail.gmail.com>
	 <1247081981.18386.10.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f199.google.com ([209.85.212.199]:64727 "EHLO
	mail-vw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbZGHU2u (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Jul 2009 16:28:50 -0400
In-Reply-To: <1247081981.18386.10.camel@johannes.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>

On Wed, Jul 8, 2009 at 12:39 PM, Johannes Berg<johannes@sipsolutions.net> wrote:
> Everybody take me off the CC please then :) This has been discussed far
> too many times already. In this special case, the warning probably isn't
> all that useful, but ISTR Linus saying that he wanted it this way.

Right. I would keep the warning in sparse. I think it is better with
the compound statement. It is easier to read which block is which.

> -       do if (ptr) {                                                   \
> +       do { if (ptr) {                                                 \

BTW, if does not hurt to put the "if (ptr)" to a separate line.

Chris
