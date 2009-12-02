From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Re: Re: Re: Getting info from used typedef
Date: Wed, 2 Dec 2009 15:05:52 +0100
Message-ID: <OF83C748CA.F60373EF-ONC1257680.004D070F-C1257680.004D7110@br-automation.com>
References: <70318cbf0910011141r78e02d78qbb7ab4f183253406@mail.gmail.com>	 <OF00751164.A668C764-ONC1257679.004B0F96-C1257679.004E5AEF@br-automation.com>
	 <70318cbf0911301541i478a4642k54423fd8ac5e83ec@mail.gmail.com>	 <OFBC143B24.B977DCC6-ONC125767F.0037DE90-C125767F.0044B96C@br-automation.com> <70318cbf0912011049w4cab5e4qa74a15371511c8a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:47708 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbZLBOFs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Dec 2009 09:05:48 -0500
In-Reply-To: <70318cbf0912011049w4cab5e4qa74a15371511c8a4@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: christ.li@gmail.com, linux-sparse@vger.kernel.org

christ.li@gmail.com schrieb am 01.12.2009 19:49:18:
> So you only use sparse as a C source code processing tool. You don't
> care about the back end part of the sparse right?

Yes, that's right.

> In that case, you can try this one line patch. It should preserve the 
typedef
> symbol as the base type. I will not commit that to main line though.
> 
> Will that work for you?

Thank you, but I'm sorry, that patch doesn't work for me. 
The output is the same as before, the base_type of the symbol doesn't have 
an ident.

I'm surprised that the base_type had an ident in former versions of sparse 

(which didn't also work correctly - I tried to figure out something in the 
past, see 
http://marc.info/?l=linux-sparse&m=118171213001092&w=2
), but now this has changed.

In former versions of sparse, this code gave output, even tough it was 
incorrect:
("sym" is a "struct symbol*" of the symlist returned by sparse() )

        struct symbol *type;
        type = sym->ctype.base_type;
 
        if (type->ident)
        {
                if (sym->ctype.modifiers & MOD_USERTYPE) 
                        fprintf(pFOut, "Typedef=\"%s\" ", 
type->ident->name);
        } 


I tried to compare the function "declaration_specifiers" from sparse 0.4.1 
and 0.4.2.
The function changed a lot, but I don't understand the changes.

Is it really not necessary for compilers (or frontends) to hold the 
information about declarations with typedefs?

Regards,
Thomas
