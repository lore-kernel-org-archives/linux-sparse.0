From: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH] sparse: Make -Werror turn warnigns into errors
Date: Wed, 3 Sep 2014 21:08:56 +0200
Message-ID: <20140903190856.GC18161@pox.localdomain>
References: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
 <20140903185939.GA24390@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57865 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbaICTI6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2014 15:08:58 -0400
Content-Disposition: inline
In-Reply-To: <20140903185939.GA24390@cloud>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@joshtriplett.org
Cc: linux-sparse@vger.kernel.org

On 09/03/14 at 11:59am, josh@joshtriplett.org wrote:
> This seems reasonable.  Sparse refrains from showing further warnings
> after an error, but this turns warnings into errors, so they'll still
> show up.
> 
> Not needed for this patch, but would you consider adding
> -Werror=specific-warning support too?  (That'll need some careful
> thought about the no-warnings-after-error logic, which may or may not
> make sense.)

Sure. I think that is definitely desirable. I wanted to collect
feedback on the behavioural change first using a minimal patch.
