From: Pavel Roskin <proski@gnu.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Tue, 30 Mar 2010 01:29:59 -0400
Message-ID: <1269926999.6838.177.camel@mj>
References: <1268097872.16227.10.camel@mj>
	 <201003292017.16866.kdudka@redhat.com>
	 <70318cbf1003291148w6b338b25v6801c3ec146af0f9@mail.gmail.com>
	 <201003292123.40443.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:20717 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab0C3FaB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 30 Mar 2010 01:30:01 -0400
In-Reply-To: <201003292123.40443.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Mon, 2010-03-29 at 21:23 +0200, Kamil Dudka wrote:

> Sure, I don't object it anyhow.  As a C++ programmer I've certainly different 
> attitude to type safety, thus biased.  I believe kernel developers would more 
> likely agree with your point of view.

If you run patched sparse on the kernel and fix the first ten warnings
in a nice, unobtrusive way, and there is no warning that you cannot fix,
chances are that the kernel developers will like your changes, even if
it makes the code look more like C++ or even Java :-)

If the fixes involve casts or conversion of enum types to integers or a
serious code reorganization, then perhaps the kernel developers won't
like your changes.

-- 
Regards,
Pavel Roskin
