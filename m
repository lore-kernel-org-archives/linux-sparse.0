From: Christopher Li <sparse@chrisli.org>
Subject: Re: Re: Re: Getting info from used typedef
Date: Wed, 20 Jan 2010 16:38:09 -0800
Message-ID: <70318cbf1001201638g4b8708e0v94160b64ed2aa854@mail.gmail.com>
References: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>
	 <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com>
	 <70318cbf0911301541i478a4642k54423fd8ac5e83ec@mail.gmail.com>
	 <OFBC143B24.B977DCC6-ONC125767F.0037DE90-C125767F.0044B96C@br-automation.com>
	 <70318cbf0912011049w4cab5e4qa74a15371511c8a4@mail.gmail.com>
	 <OF83C748CA.F60373EF-ONC1257680.004D070F-C1257680.004D7110@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:58589 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0AUAiK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 20 Jan 2010 19:38:10 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1323541qwe.37
        for <linux-sparse@vger.kernel.org>; Wed, 20 Jan 2010 16:38:09 -0800 (PST)
In-Reply-To: <OF83C748CA.F60373EF-ONC1257680.004D070F-C1257680.004D7110@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Dec 2, 2009 at 6:05 AM, Thomas Schmid
<Thomas.Schmid@br-automation.com> wrote:
>
> Thank you, but I'm sorry, that patch doesn't work for me.

I took another look into it. I think if you are just working on the
source code transform,
you should be able to skip the evaluation step which short cut the typedef.

Can you try again with the same patch, but in your program, using
__sparse(filename)
instead of sparse(filename) to get the symbols? Using __sparse will skip the
evaluation step. It should keep the typedef node unchanged.


> Is it really not necessary for compilers (or frontends) to hold the
> information about declarations with typedefs?

The back end only care about the type, not the name of type.
In fact, C type system need to evaluation the type to get ride of the
alias so it will not complain type mismatch due to typedef.

Chris
