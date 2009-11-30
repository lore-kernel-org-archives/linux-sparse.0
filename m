From: Christopher Li <sparse@chrisli.org>
Subject: Re: Getting info from used typedef
Date: Mon, 30 Nov 2009 15:41:18 -0800
Message-ID: <70318cbf0911301541i478a4642k54423fd8ac5e83ec@mail.gmail.com>
References: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>
	 <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39126 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbZK3XlN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Nov 2009 18:41:13 -0500
Received: by ewy19 with SMTP id 19so4360639ewy.21
        for <linux-sparse@vger.kernel.org>; Mon, 30 Nov 2009 15:41:18 -0800 (PST)
In-Reply-To: <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Nov 25, 2009 at 6:15 AM, Thomas Schmid
<Thomas.Schmid@br-automation.com> wrote:
> typedef signed short INT;
> INT var1;
>
> When i iterate over the symbol_list which is returend by sparse(), I can
> get the information,
> that "var1" was declared using a typedef, this information is held in
> "symbol->ctype.modifiers".

So far so good.

> Can you tell me how I can examine the name of the typedef - "INT", which
> was used in the declaration?

I take a look at the current code base, there is no good way to get the
typedef from the symbol node. When sparse parse the "INT" token.
It will try to lookup it as type define. If it is, sparse directly
apply the underlying
ctype, which is "signed short", to var1.

The code does that is in declaration_specifiers() if you are curious.
Sparse only use the base type of the user type, as if the declaration
is "signed short var1". This make the later process much easier.
It is none trivial change to preserve the type define name.

May I ask more back ground information what do you want to do
with the type define name? I am trying to find out if there is other easier
way to achieve your goal.

Chris
