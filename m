From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Antwort: Re: Getting info from used typedef
Date: Tue, 1 Dec 2009 13:30:39 +0100
Message-ID: <OFBC143B24.B977DCC6-ONC125767F.0037DE90-C125767F.0044B96C@br-automation.com>
References: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>	 <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com> <70318cbf0911301541i478a4642k54423fd8ac5e83ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:48926 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZLAMaf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Dec 2009 07:30:35 -0500
In-Reply-To: <70318cbf0911301541i478a4642k54423fd8ac5e83ec@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: christ.li@gmail.com, linux-sparse@vger.kernel.org

christ.li@gmail.com schrieb am 01.12.2009 00:41:18:

> The code does that is in declaration_specifiers() if you are curious.
> Sparse only use the base type of the user type, as if the declaration
> is "signed short var1". This make the later process much easier.
> It is none trivial change to preserve the type define name.
I see.

> May I ask more back ground information what do you want to do
> with the type define name? I am trying to find out if there is other 
easier
> way to achieve your goal.

Of course: I wrote a tool, which converts C-declarations into another 
format (IEC61131). 
These generated declarations are used as a interface to communicate to 
programs of different languages.
This IEC-format uses datatypes, which are not known in ANSI C, such as the 
following:

typedef signed long    DINT;
typedef unsigned long  UDINT;
typedef signed long    TIME;
typedef unsigned long  DATE_AND_TIME;
typedef unsigned short UINT;
typedef unsigned short WSTRING;


As you can see, the use of the basetype "unsigned long" for example is not 
clear.
If I now declare a variable of type TIME and another one of type DINT, 
I am not able to determine which type was used in the declaration.

I hope this is understandable,

regards,
Thomas
