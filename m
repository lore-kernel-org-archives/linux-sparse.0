From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Re: Re: Re: Re: Getting info from used typedef
Date: Tue, 26 Jan 2010 16:28:07 +0100
Message-ID: <OFCC691C46.FB86BED9-ONC12576B7.0053EA67-C12576B7.0054F94E@br-automation.com>
References: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>	 <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com>
	 <70318cbf0911301541i478a4642k54423fd8ac5e83ec@mail.gmail.com>	 <OFBC143B24.B977DCC6-ONC125767F.0037DE90-C125767F.0044B96C@br-automation.com>
	 <70318cbf0912011049w4cab5e4qa74a15371511c8a4@mail.gmail.com>	 <OF83C748CA.F60373EF-ONC1257680.004D070F-C1257680.004D7110@br-automation.com> <70318cbf1001201638g4b8708e0v94160b64ed2aa854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:52203 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab0AZPnO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jan 2010 10:43:14 -0500
In-Reply-To: <70318cbf1001201638g4b8708e0v94160b64ed2aa854@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, linux-sparse-owner@vger.kernel.org

linux-sparse-owner@vger.kernel.org schrieb am 21.01.2010 01:38:09:

> I took another look into it. I think if you are just working on the
> source code transform,
> you should be able to skip the evaluation step which short cut the 
typedef.
> 
> Can you try again with the same patch, but in your program, using
> __sparse(filename)
> instead of sparse(filename) to get the symbols? Using __sparse will skip 
the
> evaluation step. It should keep the typedef node unchanged.

Yes, that seems to help, thank you very much.
I think because of the missing evaluation step, it is now a little bit 
more tricky 
to get out the elements of an struct or enum, but it will work.
Do I lose anything else, skipping the evaluation step?

Is it possible to commit your change (
0001-hacking-preserve-typedef-name.patch) in source?
- I didn't recognize any change in behaviour when using the function 
sparse().


Regards
Tom


