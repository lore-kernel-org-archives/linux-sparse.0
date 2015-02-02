From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/4] Add support for show_data()
Date: Sun, 1 Feb 2015 21:30:44 -0800
Message-ID: <CANeU7Qkp-6KbTFgxe1Rvrpud66dB+J+-2XpjVDCwqkNDg4H37Q@mail.gmail.com>
References: <CANeU7QnQWRRB1kmt7KOjuJ4PFasefaX91yPZ-DEYxE2qUzxX3A@mail.gmail.com>
	<1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
	<1422757186-8007-3-git-send-email-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:44379 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbbBBFao (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2015 00:30:44 -0500
Received: by mail-qg0-f54.google.com with SMTP id q108so46097004qgd.13
        for <linux-sparse@vger.kernel.org>; Sun, 01 Feb 2015 21:30:44 -0800 (PST)
In-Reply-To: <1422757186-8007-3-git-send-email-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Sat, Jan 31, 2015 at 6:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The purpose of show_data() is to visualize data, more or less

I think show_data() is a bad name. Data is very generic term,
it has not specific meaning what exactly is that data.

What you really want to show is the initializer expression.
Make the function name reflect that.

> diff --git a/linearize.c b/linearize.c

Why is this function belongs to linearize.c?
It has nothing to do with linearization instruction. It has
every thing to do with the AST structure.

I suggest that move this code to show-parse.c.
There are many functions showing internal of the AST
there.

Chris
