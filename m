From: "Chris Li" <christ.li@gmail.com>
Subject: Re: Adding type information to instructions
Date: Mon, 7 Jul 2008 13:08:08 -0700
Message-ID: <70318cbf0807071308i5ce33e92rf7b033d5709da2a2@mail.gmail.com>
References: <486EB59C.100@cowlark.com>
	 <1215452561.3003.21.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:7419 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbYGGUIL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Jul 2008 16:08:11 -0400
Received: by ti-out-0910.google.com with SMTP id b6so599279tic.23
        for <linux-sparse@vger.kernel.org>; Mon, 07 Jul 2008 13:08:10 -0700 (PDT)
In-Reply-To: <1215452561.3003.21.camel@josh-work.beaverton.ibm.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

On Mon, Jul 7, 2008 at 10:42 AM, Josh Triplett <josht@linux.vnet.ibm.com> wrote:
> I can't think of any fundamental reason not to do this, other than the
> standard reason of data structure size.

There is other ways to avoid the size blow up. At the linearized byte
code level,
the back end only need to know it is one of the stander C type . So we have an
array of stander ctype C type similar to ctype_declaration[].

We just need to replace the size member  with the array index in the instruction
struct..

Chris
