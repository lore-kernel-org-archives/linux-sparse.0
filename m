From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Antwort: Re: [PATCH] Fix implicit cast to float (Was:Re: Initializing float
 	variables without type suffix)
Date: Mon, 9 Feb 2009 14:38:55 +0100
Message-ID: <OF56CB73D3.5EA2DB0D-ONC1257558.00499FF2-C1257558.004AEC1A@br-automation.com>
References: <70318cbf0902082337r250543c8ic94c0f8f6517565a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:35428 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbZBINii (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Feb 2009 08:38:38 -0500
In-Reply-To: <70318cbf0902082337r250543c8ic94c0f8f6517565a@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: christ.li@gmail.com, Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org

christ.li@gmail.com schrieb am 09.02.2009 08:37:50:

> On Fri, Feb 6, 2009 at 4:51 AM, Thomas Schmid
> <Thomas.Schmid@br-automation.com> wrote:
> > christ.li@gmail.com schrieb am 06.02.2009 05:15:37:
> > -       if (newtype->ctype.base_type != &fp_type) {
> > +       if (is_int_type(newtype)) {
> 
> I change your patch a little bit. The old logic of testing against float
> type is better. The type can be a pointer for example. Then using
> the long long value is more correct.
> 
> See the patch attached.
> 
> If there is not objections. I am going to apply this one.

Thank you for correcting, your changes work fine for me.

There's only a little problem with the patch,
patch breaks off in evaluate.c, cause there's no function "is_void_type" 
within...

Greetings
Thomas Schmid
