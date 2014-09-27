From: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH v2] sparse: Make -Werror turn warnigns into errors
Date: Sat, 27 Sep 2014 08:11:36 +0100
Message-ID: <20140927071136.GA10174@casper.infradead.org>
References: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
 <CANeU7QnM-sns1pOgjpOrKp2LkMnf7O=89XSvF7hCuzvrwg5bPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57485 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbaI0HLi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Sep 2014 03:11:38 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QnM-sns1pOgjpOrKp2LkMnf7O=89XSvF7hCuzvrwg5bPw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 09/27/14 at 08:24am, Christopher Li wrote:
> While I apply the patch, I notice this piece. Sparse has the on/off switch list.
> "Werror" seems should belong to that list. Gcc accept "-Wno-error" to turn off
> the switch. However, we might not want "-Wsparse-all" to turn on "Werror".
> 
> So I have the incremental patch to convert "Werror" using the on/off
> switch list.
> 
> Feed back?

Sure
