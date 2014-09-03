From: josh@joshtriplett.org
Subject: Re: [PATCH] sparse: Make -Werror turn warnigns into errors
Date: Wed, 3 Sep 2014 11:59:39 -0700
Message-ID: <20140903185939.GA24390@cloud>
References: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50150 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302AbaICS7o (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2014 14:59:44 -0400
Content-Disposition: inline
In-Reply-To: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: linux-sparse@vger.kernel.org

On Wed, Sep 03, 2014 at 08:54:05PM +0200, Thomas Graf wrote:
> Make sparse fail and return an error code if a warning is encountered
> and -Werror is specified or a hard error is found. This allows to use
> sparse in automated build systems to more easily catch new sparse
> warnings.
> 
> Due to sparse now returning non zero on failure, the test cases
> triggering a error have to be adapated to check for the non zero return
> value.
> 
> Also changes cgcc to die if the checker fails.
> 
> Signed-off-by: Thomas Graf <tgraf@suug.ch>

This seems reasonable.  Sparse refrains from showing further warnings
after an error, but this turns warnings into errors, so they'll still
show up.

Not needed for this patch, but would you consider adding
-Werror=specific-warning support too?  (That'll need some careful
thought about the no-warnings-after-error logic, which may or may not
make sense.)

- Josh Triplett
