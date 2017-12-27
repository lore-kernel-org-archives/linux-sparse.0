From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] Introduce __cond_lock_err
Date: Wed, 27 Dec 2017 15:38:50 +0100
Message-ID: <20171227143850.nnuatshhezurbu7r@ltop.local>
References: <20171219165823.24243-1-willy@infradead.org>
 <20171219165823.24243-2-willy@infradead.org>
 <20171221214810.GC9087@linux.intel.com>
 <20171222011000.GB23624@bombadil.infradead.org>
 <20171222042120.GA18036@localhost>
 <20171222123112.GA6401@bombadil.infradead.org>
 <20171222133634.GE6401@bombadil.infradead.org>
 <20171223093910.GB6160@localhost>
 <20171223130621.GA3994@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20171223130621.GA3994@bombadil.infradead.org>
Sender: owner-linux-mm@kvack.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Dec 23, 2017 at 05:06:21AM -0800, Matthew Wilcox wrote:
> On Sat, Dec 23, 2017 at 01:39:11AM -0800, Josh Triplett wrote:
> > +linux-sparse
> 
> Ehh ... we've probably trimmed too much to give linux-sparse a good summary.
> 
> Here're the important lines from my patch:
> 
> +# define __cond_lock_err(x,c)  ((c) ? 1 : ({ __acquire(x); 0; }))
> 
> +       return __cond_lock_err(*ptlp, __follow_pte_pmd(mm, address, start, end,
> +                                                   ptepp, pmdpp, ptlp));
> 
> This is supposed to be "If "c" is an error value, we don't have a lock,
> otherwise we have a lock".  And to translate from linux-speak into
> sparse-speak:
> 
>  # define __acquire(x)  __context__(x,1)
> 
> Josh & Ross pointed out (quite correctly) that code which does something like
> 
> if (foo())
> 	return;
> 
> will work with this, but code that does
> 
> if (foo() < 0)
> 	return;
> 
> will not because we're now returning 1 instead of -ENOMEM (for example).
> 
> So they made the very sensible suggestion that I change the definition
> of __cond_lock to:
> 
> # define __cond_lock_err(x,c)  ((c) ?: ({ __acquire(x); 0; }))
> 
> Unfortunately, when I do that, the context imbalance warning returns.
> As I said below, this is with sparse 0.5.1.

I think this __cond_lock_err() is now OK (but some comment about
how its use is different from __cond_lock() would be welcome).

For the context imbalance, I would really need a concrete example
to be able to help more because it depends heavily on what the
test is and what code is before and after.

If you can point me to a tree, a .config and a specific warning,
I'll be glad to take a look.

-- Luc Van Oostenryck

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
