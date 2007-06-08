From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: sparse missing bitwise warnings with dubious bitfields
Date: Fri, 8 Jun 2007 14:19:09 +0100
Message-ID: <20070608131909.GZ4095@ftp.linux.org.uk>
References: <1181291050.6533.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:53539 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937395AbXFHNTL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2007 09:19:11 -0400
Content-Disposition: inline
In-Reply-To: <1181291050.6533.19.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse <linux-sparse@vger.kernel.org>, Michael Wu <flamingice@sourmilk.net>, Christoph Hellwig <hch@infradead.org>

On Fri, Jun 08, 2007 at 10:24:10AM +0200, Johannes Berg wrote:
> $ sparse test.c -DDUBIOUS
> test.c:3:10: error: dubious one-bit signed bitfield
> 
> [note that no warning about the bitwise error is there!]

... or any other warnings, for that matter.

Error turns the warnings off.
