From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] adding into middle of RCU list
Date: Sun, 1 Sep 2013 13:42:10 -0700
Message-ID: <20130901204209.GA20802@leaf>
References: <20130822213318.49a57fa2@nehalam.linuxnetplumber.net>
 <20130823164637.GB3871@linux.vnet.ibm.com>
 <20130823171653.GA16558@Krystal>
 <20130823210822.GD3871@linux.vnet.ibm.com>
 <20130830005733.GA20664@linux.vnet.ibm.com>
 <20130830021637.GA21862@leaf>
 <20130831213228.GF3871@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52653 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab3IAUmU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Sep 2013 16:42:20 -0400
Content-Disposition: inline
In-Reply-To: <20130831213228.GF3871@linux.vnet.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Stephen Hemminger <stephen@networkplumber.org>, lttng-dev@lists.lttng.org, sparse@chrisli.org, linux-sparse@vger.kernel.org

On Sat, Aug 31, 2013 at 02:32:28PM -0700, Paul E. McKenney wrote:
> On Thu, Aug 29, 2013 at 07:16:37PM -0700, Josh Triplett wrote:
> > On Thu, Aug 29, 2013 at 05:57:33PM -0700, Paul E. McKenney wrote:
> > > On Fri, Aug 23, 2013 at 02:08:22PM -0700, Paul E. McKenney wrote:
> > > > On Fri, Aug 23, 2013 at 01:16:53PM -0400, Mathieu Desnoyers wrote:
> > > > > #define __rcu_assign_pointer(p, v, space) \
> > > > >         do { \
> > > > >                 smp_wmb(); \
> > > > >                 (p) = (typeof(*v) __force space *)(v); \
> > > > >         } while (0)
> > > > 
> > > > Or I need to fix this one as well.  ;-)
> > > 
> > > In that vein...  Is there anything like typeof() that also preserves
> > > sparse's notion of address space?  Wrapping an ACCESS_ONCE() around
> > > "p" in the assignment above results in sparse errors.
> > 
> > typeof() will preserve sparse's notion of address space as long as you
> > do typeof(p), not typeof(*p):
> > 
> > $ cat test.c
> > #define as(n) __attribute__((address_space(n),noderef))
> > #define __force __attribute__((force))
> > 
> > int main(void)
> > {
> >     int target = 0;
> >     int as(1) *foo = (__force typeof(target) as(1) *) &target;
> >     typeof(foo) bar = foo;
> >     return *bar;
> > }
> > $ sparse test.c
> > test.c:9:13: warning: dereference of noderef expression
> > 
> > Notice that sparse didn't warn on the assignment of foo to bar (because
> > typeof propagated the address space of 1), and warned on the dereference
> > of bar (because typeof propagated noderef).
> 
> Thank you for the info!
> 
> Suppose that I want to do something like this:
> 
> #define __rcu_assign_pointer(p, v, space) \
>         do { \
>                 smp_wmb(); \
>                 ACCESS_ONCE(p) = (typeof(*v) __force space *)(v); \
>         } while (0)
> 
> Now, this does typeof(*p), so as you noted above sparse complains about
> address-space mismatches.  Thus far, I haven't been able to come up with
> something that (1) does sparse address-space checking, (2) does C type
> checking, and (3) forces the assignment to be volatile.
> 
> Any thoughts on how to do this?

First of all, if p and v had compatible types *including* address
spaces, you wouldn't need the "space" argument; the following
self-contained test case passes both sparse and GCC typechecking:

#define as(n) __attribute__((address_space(n),noderef))
#define __force __attribute__((force))
#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
extern void smp_wmb(void);

#define rcu_assign_pointer(p, v) \
    do { \
        smp_wmb(); \
        ACCESS_ONCE(p) = (v); \
    } while (0)

struct foo;

int main(void)
{
    struct foo as(1) *dest;
    struct foo as(1) *src = (void *)0;

    rcu_assign_pointer(dest, src);

    return 0;
}



But in this case, you want dest and src to have compatible types except
that dest must have the __rcu address space and src might not.  So,
let's change the types of dest and src, and add the appropriate cast.
The following also passes both GCC and sparse:

#define __rcu __attribute__((address_space(4),noderef))
#define __force __attribute__((force))
#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
extern void smp_wmb(void);

#define rcu_assign_pointer(p, v) \
    do { \
        smp_wmb(); \
        ACCESS_ONCE(p) = (typeof(*(v)) __rcu __force *)(v); \
    } while (0)

struct foo { int x; };

int main(void)
{
    struct foo __rcu *dest;
    struct foo *src = (void *)0;

    rcu_assign_pointer(dest, src);

    return 0;
}


However, that cast forces the source to have the __rcu address space
without checking what address space it started out with.  If you want to
verify that the source has the kernel address space, you can cast to
that address space first, *without* __force, which will warn if the
source doesn't start out with that address space:

#define __kernel __attribute__((address_space(0)))
#define __user __attribute__((address_space(1),noderef))
#define __rcu __attribute__((address_space(4),noderef))
#define __force __attribute__((force))
#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
extern void smp_wmb(void);

#define rcu_assign_pointer(p, v) \
    do { \
        smp_wmb(); \
        ACCESS_ONCE(p) = (typeof(*(v)) __rcu __force *)(typeof(*(v)) __kernel *)(v); \
    } while (0)

struct foo { int x; };

int main(void)
{
    struct foo __rcu *dest;
    struct foo *src = (void *)0;
    struct foo __user *badsrc = (void *)0;

    rcu_assign_pointer(dest, src);
    rcu_assign_pointer(dest, badsrc);

    return 0;
}


This produces a warning on the line using badsrc:

test.c:23:5: warning: cast removes address space of expression

However, that doesn't seem like the most obvious warning, since
rcu_assign_pointer doesn't look like a cast, and since it doesn't print
the full types involved like most address space warnings do.  So,
instead, let's add and use a __chk_kernel_ptr function, similar to
__chk_user_ptr in compiler.h:

#define __kernel __attribute__((address_space(0)))
#define __user __attribute__((address_space(1),noderef))
#define __rcu __attribute__((address_space(4),noderef))
#define __force __attribute__((force))
#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
extern void __chk_kernel_ptr(const volatile void *);
extern void smp_wmb(void);

#define rcu_assign_pointer(p, v) \
    do { \
        smp_wmb(); \
        __chk_kernel_ptr(v); \
        ACCESS_ONCE(p) = (typeof(*(v)) __rcu __force *)(v); \
    } while (0)

struct foo { int x; };

int main(void)
{
    struct foo __rcu *dest;
    struct foo *src = (void *)0;
    struct foo __user *badsrc = (void *)0;

    rcu_assign_pointer(dest, src);
    rcu_assign_pointer(dest, badsrc);

    return 0;
}


This produces a somewhat better warning:

test.c:25:5: warning: incorrect type in argument 1 (different address spaces)
test.c:25:5:    expected void const volatile *<noident>
test.c:25:5:    got struct foo [noderef] <asn:1>*badsrc

That at least shows the full type of badsrc, but it still seems
suboptimal for two reasons: it says it expects "void const volatile *"
rather than the actual type it wants, and it says "in argument 1" (of
__chk_kernel_ptr), which seems unnecessarily confusing when the type
error actually applies to argument 2 of rcu_assign_pointer.  We can do
better by declaring a fake local function for checking, instead:

#define __kernel __attribute__((address_space(0)))
#define __user __attribute__((address_space(1),noderef))
#define __rcu __attribute__((address_space(4),noderef))
#define __force __attribute__((force))
#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
extern void smp_wmb(void);

#define rcu_assign_pointer(p, v) \
    do { \
        smp_wmb(); \
        extern void __rcu_assign_pointer_typecheck(int, typeof(*(v)) __kernel *); \
        __rcu_assign_pointer_typecheck(0, v); \
        ACCESS_ONCE(p) = (typeof(*(v)) __rcu __force *)(v); \
    } while (0)

struct foo { int x; };

int main(void)
{
    struct foo __rcu *dest;
    struct foo *src = (void *)0;
    struct foo __user *badsrc = (void *)0;

    rcu_assign_pointer(dest, src);
    rcu_assign_pointer(dest, badsrc);

    return 0;
}


This last approach produces a very clear warning:

test.c:25:5: warning: incorrect type in argument 2 (different address spaces)
test.c:25:5:    expected struct foo *<noident>
test.c:25:5:    got struct foo [noderef] <asn:1>*badsrc

If you want, you can even add an argument name for the second argument
of __rcu_assign_pointer_typecheck, and it'll replace the <noident> in
the second line of the warning.

So, that last approach meets all the criteria you mentioned:
> something that (1) does sparse address-space checking, (2) does C type
> checking, and (3) forces the assignment to be volatile.

Will that work for all the use cases you have in mind?  If so, I'll
submit a patch changing rcu_assign_pointer to use that approach.

- Josh Triplett
