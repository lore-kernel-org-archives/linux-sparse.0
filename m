From: Christopher Li <sparse@chrisli.org>
Subject: Re: Re: Re: Re: Getting info from used typedef
Date: Thu, 28 Jan 2010 17:21:18 -0800
Message-ID: <70318cbf1001281721p1b0df85ey63e58062dd7d809@mail.gmail.com>
References: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>
	 <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com>
	 <70318cbf0911301541i478a4642k54423fd8ac5e83ec@mail.gmail.com>
	 <OFBC143B24.B977DCC6-ONC125767F.0037DE90-C125767F.0044B96C@br-automation.com>
	 <70318cbf0912011049w4cab5e4qa74a15371511c8a4@mail.gmail.com>
	 <OF83C748CA.F60373EF-ONC1257680.004D070F-C1257680.004D7110@br-automation.com>
	 <70318cbf1001201638g4b8708e0v94160b64ed2aa854@mail.gmail.com>
	 <OFCC691C46.FB86BED9-ONC12576B7.0053EA67-C12576B7.0054F94E@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:41825 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756569Ab0A2BVT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jan 2010 20:21:19 -0500
In-Reply-To: <OFCC691C46.FB86BED9-ONC12576B7.0053EA67-C12576B7.0054F94E@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org, linux-sparse-owner@vger.kernel.org

On Tue, Jan 26, 2010 at 7:28 AM, Thomas Schmid
<Thomas.Schmid@br-automation.com> wrote:
>
> Yes, that seems to help, thank you very much.
> I think because of the missing evaluation step, it is now a little bit
> more tricky
> to get out the elements of an struct or enum, but it will work.
> Do I lose anything else, skipping the evaluation step?

You don't have the type evaluation. I don't think your source code
transform program
cares.
>
> Is it possible to commit your change (
> 0001-hacking-preserve-typedef-name.patch) in source?
> - I didn't recognize any change in behaviour when using the function
> sparse().

How about make it an hidden options? It does not make sense for compiler
to care about the typedef name. I will send out a review later.

Chris
