From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse warnings on undeclared asmlinkage
Date: Fri, 11 Oct 2019 20:53:49 +0200
Message-ID: <20191011185348.pkfsexr742x5xwgm@ltop.local>
References: <67799c6b-77c1-8488-9595-38ca734e8d5f@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <67799c6b-77c1-8488-9595-38ca734e8d5f@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Oct 11, 2019 at 05:18:58PM +0100, Ben Dooks wrote:
> I was reviewing the sparse output for the current kernel release and
> note there are a number of warnings about un-declared functions which
> are only used for code in assembly.
> 
> I was wondering if we should just ignore those, and have either a
> new attribute for "undeclared is ok" or to make spare just ignore
> anything with the syscall_linkage attribute?

There is already an attribute and it's corresponding kernel define:
__attribute__((__externally_visible__)), aka __visible.

My point of view on the subject is more about the lines:
* who knows about __visble/externally_visible?
* what's wrong/are the disadvantge to adding the prototype?
But it seems that some maintainers are against using prototypes
for functions only used in assembly.

Cheers,
-- Luc
