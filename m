From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Backend projects for Sparse
Date: Wed, 28 Nov 2007 11:25:34 -0800
Message-ID: <70318cbf0711281125u6cc168dfv11d118741a535167@mail.gmail.com>
References: <1196243580.474d3a7c9895b@mail.physics.auth.gr>
	 <70318cbf0711281053k6dc561c5ge540ccd99a6a922e@mail.gmail.com>
	 <474DBAB3.60400@physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:55827 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbXK1TZf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Nov 2007 14:25:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1320037rvb
        for <linux-sparse@vger.kernel.org>; Wed, 28 Nov 2007 11:25:34 -0800 (PST)
In-Reply-To: <474DBAB3.60400@physics.auth.gr>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nikolaos Kavvadias <nkavv@physics.auth.gr>
Cc: linux-sparse@vger.kernel.org

On Nov 28, 2007 11:00 AM, Nikolaos Kavvadias <nkavv@physics.auth.gr> wrote:
> first of all, thanks for your specific answers. The SSA form that i
> think of uses only PHI functions. Guard variables (conditionals for
> selecting a specific usage) may or may not be explicit. Usually, most
> SSA forms just specify which uses are merged. The conditionals can be
> inferred by control-flow analysis.

We have PHI node embed in the instruction list as one of the fake instruction.
Then we have the PHI source node to indicate the output edge of the PHI node.

It seems that should fit your need.

Chris
