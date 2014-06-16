From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] tell gcc optimizer to never introduce new data races
Date: Mon, 16 Jun 2014 13:20:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406161320180.1321@pobox.suse.cz>
References: <alpine.LNX.2.00.1406101517300.9378@pobox.suse.cz> <20140616102927.GA2994@mwanda> <mvmsin51605.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmsin51605.fsf@hawking.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Jambor <mjambor@suse.cz>, Petr Mladek <pmladek@suse.cz>, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, 16 Jun 2014, Andreas Schwab wrote:

> > Adding "--param allow-store-data-races=0" to the GCC options for the
> > kernel breaks C=1 because Sparse isn't expecting a GCC option with that
> > format.
> 
> Please try --param=allow-store-data-races=0 instead.

How reliable is this format across GCC versions? GCC manpage doesn't seem 
to list it as a valid alternative.

-- 
Jiri Kosina
SUSE Labs
