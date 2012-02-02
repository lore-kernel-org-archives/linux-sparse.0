From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Thu, 02 Feb 2012 12:50:19 +1100
Message-ID: <1328147419.28487.96.camel@pasglop>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	 <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
	 <4F29E0E1.3000504@garzik.org> <1328145724.28487.95.camel@pasglop>
	 <CANeU7QnDStpUovGKpLdV1zw=jJc0X1LrdmeAS2x-e8xdX+J6og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33135 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383Ab2BBBux (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 20:50:53 -0500
In-Reply-To: <CANeU7QnDStpUovGKpLdV1zw=jJc0X1LrdmeAS2x-e8xdX+J6og@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

On Wed, 2012-02-01 at 17:33 -0800, Christopher Li wrote:
> 
> Do you mean take a pseudo then shoot out a llvm ref? The pseudo is
> the more general form, a pseudo can come from symbol node or
> expressions (function pointers). 

But in both cases the type itself is a struct symbol isn't it ? Either a
function def as Linus patch provides or base_type which is a struct
symbol too....

Sure if we have a consistent pseudo->type that covers both cases then we
can just pass that along, I don't mind.

Cheers,
Ben.


