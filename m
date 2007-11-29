From: nkavv@physics.auth.gr
Subject: Re: Backend projects for Sparse
Date: Thu, 29 Nov 2007 11:09:20 +0200
Message-ID: <1196327360.474e81c0546d7@mail.physics.auth.gr>
References: <1196243580.474d3a7c9895b@mail.physics.auth.gr>  <70318cbf0711281053k6dc561c5ge540ccd99a6a922e@mail.gmail.com>  <474DBAB3.60400@physics.auth.gr> <70318cbf0711281125u6cc168dfv11d118741a535167@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sisifos.physics.auth.gr ([155.207.123.6]:58005 "EHLO
	physics.auth.gr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751356AbXK2JJV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 Nov 2007 04:09:21 -0500
Received: from srv003.physics.auth.gr (HELO localhost) ([10.206.123.203])
          (envelope-sender <nkavv@physics.auth.gr>)
          by physics.auth.gr (qmail-ldap-1.03) with SMTP
          for <linux-sparse@vger.kernel.org>; 29 Nov 2007 09:09:20 -0000
In-Reply-To: <70318cbf0711281125u6cc168dfv11d118741a535167@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Quoting Christopher Li <sparse@chrisli.org>:

> On Nov 28, 2007 11:00 AM, Nikolaos Kavvadias <nkavv@physics.auth.gr> wrote:
> > first of all, thanks for your specific answers. The SSA form that i
> > think of uses only PHI functions. Guard variables (conditionals for
> > selecting a specific usage) may or may not be explicit. Usually, most
> > SSA forms just specify which uses are merged. The conditionals can be
> > inferred by control-flow analysis.
>
> We have PHI node embed in the instruction list as one of the fake
> instruction.
> Then we have the PHI source node to indicate the output edge of the PHI node.
>
> It seems that should fit your need.
>
> Chris

OK, so it marks where the uses are merged.

Jeff: thanks for clearing up the "linearize" issue.

Nikolaos Kavvadias
