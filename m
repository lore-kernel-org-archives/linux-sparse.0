From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net-next] net: can: Fix compiling warning
Date: Tue, 13 Aug 2019 15:48:39 +0300
Message-ID: <20190813124838.GN1935@kadam>
References: <20190802033643.84243-1-maowenan@huawei.com>
 <0050efdb-af9f-49b9-8d83-f574b3d46a2e@hartkopp.net>
 <20190806135231.GJ1974@kadam>
 <6e1c5aa0-8ed3-eec3-a34d-867ea8f54e9d@hartkopp.net>
 <20190807105042.GK1974@kadam>
 <201908121001.0AC0A90@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201908121001.0AC0A90@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Nicolai Stange <nicstange@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Patrick Bellasi <patrick.bellasi@arm.com>, linux-sparse@vger.kernel.org, Mao Wenan <maowenan@huawei.com>, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Aug 12, 2019 at 10:19:27AM -0700, Kees Cook wrote:
> On Wed, Aug 07, 2019 at 01:50:42PM +0300, Dan Carpenter wrote:
> > On Tue, Aug 06, 2019 at 06:41:44PM +0200, Oliver Hartkopp wrote:
> > > I compiled the code (the original version), but I do not get that "Should it
> > > be static?" warning:
> > > 
> > > user@box:~/net-next$ make C=1
> > >   CALL    scripts/checksyscalls.sh
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   DESCEND  objtool
> > >   CHK     include/generated/compile.h
> > >   CHECK   net/can/af_can.c
> > > ./include/linux/sched.h:609:43: error: bad integer constant expression
> > > ./include/linux/sched.h:609:73: error: invalid named zero-width bitfield
> > > `value'
> > > ./include/linux/sched.h:610:43: error: bad integer constant expression
> > > ./include/linux/sched.h:610:67: error: invalid named zero-width bitfield
> > > `bucket_id'
> > >   CC [M]  net/can/af_can.o
> > 
> > The sched.h errors suppress Sparse warnings so it's broken/useless now.
> > The code looks like this:
> > 
> > include/linux/sched.h
> >    613  struct uclamp_se {
> >    614          unsigned int value              : bits_per(SCHED_CAPACITY_SCALE);
> >    615          unsigned int bucket_id          : bits_per(UCLAMP_BUCKETS);
> >    616          unsigned int active             : 1;
> >    617          unsigned int user_defined       : 1;
> >    618  };
> > 
> > bits_per() is zero and Sparse doesn't like zero sized bitfields.
> 
> I just noticed these sparse warnings too -- what's happening here? Are
> they _supposed_ to be 0-width fields? It doesn't look like it to me:

I'm sorr, I don't even know what code I was looking at before.  I think
my cscope database was stale?  You're right.  Sparse doesn't think it's
zero, it knows that it is 11 and 3.

What's happening is that it's failing the test in in
bad_integer_constant_expression():

	if (!(expr->flags & CEF_ICE))

The ICE in CEF_ICE stands for Integer Constant Expression.  The rule
here is that enums are not constant expressions in c99.  See the
explanation in commit 274c154704db ("constexpr: introduce additional
expression constness tracking flags").

I don't think the CEF_ICE is set properly in evaluate_conditional_expression().
If conditional is constant and it's true and the ->cond_true expression
is constant then the result should be constant as well.  It shouldn't
matter if the cond_false is constant.  But instead it is ANDing all
three sub expressions:

	expr->flags = (expr->conditional->flags & (*true)->flags &
			expr->cond_false->flags & ~CEF_CONST_MASK);

Or actually in this case it's doing:

	if (expr->conditional->flags & (CEF_ACE | CEF_ADDR))
		expr->flags = (*true)->flags & expr->cond_false->flags & ~CEF_CONST_MASK;

But it's the same problem because it's should ignore cond_false.

regards,
dan carpenter
