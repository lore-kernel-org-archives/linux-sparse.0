From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [PATCH] simplify: conservative handling of casts with pointers
Date: Thu, 10 May 2012 14:20:49 +0200
Message-ID: <4FABB2A1.4090503@seznam.cz>
References: <4FA92A18.1090208@seznam.cz>	<4FAA4E4A.8000409@seznam.cz> <CANeU7QkxsdXw8q-Nw09EEhzjm=vL9NePcPyB9nLRHRF56dsyLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep28.mx.upcmail.net ([62.179.121.48]:48033 "EHLO
	fep28.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab2EJMVB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 08:21:01 -0400
In-Reply-To: <CANeU7QkxsdXw8q-Nw09EEhzjm=vL9NePcPyB9nLRHRF56dsyLg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 05/10/2012 12:42 PM, Christopher Li wrote:
> The early sparse back end does not care about preserve the
> ctype in the back end. The type has been simplify to bit size.
> So the pointer type conversion which has the same bit size,
> it does not need to generate any back end machine code
> e.g. x86 instruction to perform the conversion. I think that
> is why it is skipped.
> 
> The recent changes, especially the llvm back end care more
> about preserving the ctype in the back end instruction level.

As far as I can tell, the type can be recovered reliably, one way
or the other, and missing pointer cast was one of a few (if not
only one) source of type loss in the instruction stream (e.g., with
those pointers returned by function call as demonstrated).

> The patch is applied.

Thanks.

-- Jan
