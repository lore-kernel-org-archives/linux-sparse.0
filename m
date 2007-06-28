From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 03:01:18 -0400
Message-ID: <46835CBE.6010608@garzik.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk> <46834FA0.8010201@freedesktop.org> <46835471.4070000@garzik.org> <46835B0F.4080606@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46677 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760228AbXF1HBX (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 03:01:23 -0400
In-Reply-To: <46835B0F.4080606@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

Josh Triplett wrote:
> However, in the meantime, GCC doesn't seem to have any such thing.  How do we
> want to implement it in Sparse?  I don't think we have enough information on
> the GCC command line.  I suppose we could allow specifying an architecture
> explicitly; for cgcc, we could also allow specifying the compiler name for
> cross-compilation and then deriving the architecture name from the compiler
> name if not explicitly specified.

Judging from existing software, "--target foo" to set the target arch 
should be familiar to many.  If not specified, detect the current arch 
at runtime, and use the results of the detection as the target arch.

	Jeff
