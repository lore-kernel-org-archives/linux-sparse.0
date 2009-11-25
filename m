From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Getting info from used typedef
Date: Wed, 25 Nov 2009 15:15:50 +0100
Message-ID: <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com>
References: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:64883 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964900AbZKYOat (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Nov 2009 09:30:49 -0500
In-Reply-To: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, linux-sparse-owner@vger.kernel.org

Hello,

I try to get information about a typedef, which was used in a declaration.

For example:

typedef signed short INT;
INT var1;

When i iterate over the symbol_list which is returend by sparse(), I can 
get the information,
that "var1" was declared using a typedef, this information is held in 
"symbol->ctype.modifiers".
Can you tell me how I can examine the name of the typedef - "INT", which 
was used in the declaration?
I'm only able to get the name of the basic datatype, which is "signed 
short" in this case.

This behaviour has changed in 0.4.2, in former versions the name of a used 
typedef was stored in the used datatypes ident
(altough the behaviour was erroneous there).

Thanks in advance,
regards,
Thomas

