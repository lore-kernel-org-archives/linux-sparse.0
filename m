From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: checkpatch warnings in sched.h
Date: Fri, 20 Sep 2019 13:25:35 +0300
Message-ID: <20190920102535.GA25547@kadam>
References: <CAH2r5mu1+muust_HA8oOWjYSmH6cLZA-d7pRzGJJsHauoDdJdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAH2r5mu1+muust_HA8oOWjYSmH6cLZA-d7pRzGJJsHauoDdJdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <christ.li@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 20, 2019 at 02:34:46AM -0500, Steve French wrote:
> Any hints to get rid of the noisy warnings in sched.h that make it
> hard to spot real warnings:
> 
> /include/linux/sched.h:609:43: error: bad integer constant expression
> /include/linux/sched.h:609:73: error: invalid named zero-width bitfield `value'
> 

This is a bug in Sparse and it's way worse than you think.  It actually
disables the real Sparse warnings because now Sparse thinks it has
encountered a parse error.  I think we should just ifdef out that Sparse
code.

The problem is that if you have code like:

	1 ? 1 :__bits_per()

GCC treats that as a compile constant but Sparse says that it's not
because all three elements of the conditional statement have to be
constant.  See the code in evaluate_conditional_expression().  The
complication is that Sparse sets the constant flags before calls
expand_expression() to see what the condition part of the statement is
so the code needs to shuffled around to set the constant bits to match
GCC.

I'm going to #ifdef this out for Smatch later today but someone needs
to do the same thing in Sparse because right now no one can check for
endian bugs until this gets fixed.  It's been broken for a month so
we'll probably get a flood of patches marking functions as static once
we patch this and people start seeing that warning again.

regards,
dan carpenter
