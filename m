From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Antwort: Re: Finding all typedefs
Date: Thu, 2 Aug 2007 09:31:34 +0200
Message-ID: <OF8B0579A2.47A003A7-ONC125732B.00280B65-C125732B.00295803@br-automation.com>
References: <46B12226.1070802@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.br-automation.com ([213.33.116.60]:47189 "EHLO
	mail1.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbXHBHvY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Aug 2007 03:51:24 -0400
In-Reply-To: <46B12226.1070802@codethink.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rob Taylor <rob.taylor@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org, Pavel Roskin <proski@gnu.org>

linux-sparse-owner@vger.kernel.org schrieb am 02.08.2007 02:15:34:

> Another annoying thing is that the types are always resolved for
> typedefs. i.e. for
> 
> typedef int foo;
> foo bar;
> 
> the symbol for bar has a base type of int.

...and a base_type->ident named "foo". But if you add another typedef on 
"int", i.e.

        typedef int DINT; 

base_type->ident changes to "DINT", now there's no way to get out, that 
symbol "bar" was declared with "foo".
Tell me if I'm wrong, but a solution for this would also help me on that:
http://marc.info/?l=linux-sparse&m=118171213001092&w=2

> Any suggestions for how to solve this would be greatly appreciated :)
I agree! ;-)

Best regards,
Thomas Schmid
