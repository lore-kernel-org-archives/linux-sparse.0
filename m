From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Using sparse to catch invalid RCU dereferences?
Date: Thu, 10 Apr 2008 15:32:06 -0700
Message-ID: <20080410223206.GI8419@linux.vnet.ibm.com>
References: <1207605856.12481.35.camel@johannes.berg> <20080408155259.GA8381@linux.vnet.ibm.com> <1207771787.7442.45.camel@johannes.berg>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:53809 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYDJWcI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 18:32:08 -0400
Content-Disposition: inline
In-Reply-To: <1207771787.7442.45.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-sparse <linux-sparse@vger.kernel.org>

On Wed, Apr 09, 2008 at 10:09:46PM +0200, Johannes Berg wrote:
>=20
> > It might be.  There are a number of places where it is legal to acc=
ess
> > RCU-protected pointers directly, and all of these would need to be
> > changed.  For example, in the example above, one could do:
> >=20
> > 	foo =3D NULL;
>=20
> Ok, that I understand, but sparse always treats NULL specially anyway=
=2E

But "int foo =3D 0;" would need the memory barrier -- index 0 of some
RCU-protected array.

> > I recently tried to modify rcu_assign_pointer() to issue the memory
> > memory barrier only when the pointer was non-NULL, but this ended b=
adly.
>=20
> Hm? I thought that's in the current tree.

It was for a bit.  Build failures in odd (but very real) circumstances.

> > Probably because I am not the greatest gcc expert around...  We end=
ed
> > up having to define an rcu_assign_index() to handle the possibility=
 of
> > assigning a zero-value array index, but my attempts to do type-chec=
king
> > backfired, and I eventually gave it up.  Again, someone a bit more =
clued
> > in to gcc than I am could probably pull it off.
>=20
> Ah, ok.
>=20
> > In addition, it is legal to omit rcu_dereference() and rcu_assign_p=
ointer()
> > when holding the update-side lock.
>=20
> That I don't understand. Well, I do understand that omitting
> rcu_dereference() is ok, but it seems to me that the memory and compi=
ler
> barrier in rcu_assign_pointer() is actually needed.

You are right -- I was confused.  The case where you can omit the
rcu_assign_pointer() would be when building a multiple-element data
structure that is then published as a unit.  For example:

	p =3D kmalloc(sizeof(*p), GFP_KERNEL);
	q =3D kmalloc(sizeof(*p), GFP_KERNEL);
	p->next =3D q; /* don't need rcu_assign_pointer() here. */
	q->next =3D NULL;  /* or here. */
	/* initialize other fields of p and q. */
	rcu_assign_pointer(global_pointer, p);

The assignment to p->next doesn't have to be rcu_assign_pointer() becau=
se
other CPUs are unable to access the data structure -- only the final
assignment that publishes the whole group need be rcu_assign_pointer().
On the other hand, the cost of the extra memory barrier would be
insignificant in most cases.

> I've been playing a bit, see below for my play rcupdate.h and test.c
> test program.
>=20
> Unfortunately, sparse doesn't have the ability to declare
> "=EF=BB=BF__attribute__((force_bitwise)) typeof(p)" or even
> "=EF=BB=BF__attribute__((force)) typeof(p)" which makes this force mo=
re than
> necessary and causes it to not catch when incompatible pointers are
> used. gcc notices that because I only do a cast at all for sparse, bu=
t
> that doesn't help, since e.g. list_for_each_entry_rcu() requires that
> the correct type is returned. So without sparse supporting the latter
> notation, we don't stand a chance.

"<feff>"???

> Also, I wouldn't know how to declare that an array or so needs
> rcu-access to the members.

Hmmm...  Can you apply the address-space attribute to the array itself?
I suppose one could convert the array to a pointer, but yecch!

						Thanx, Paul

> johannes
>=20
>=20
> rcupdate.h:
>=20
> #define USE_BITWISE
>=20
> #ifdef __CHECKER__
> #ifdef USE_BITWISE
> #define __rcu __attribute__((bitwise))
> #define __force_rcu_cast(p) (*((__attribute__((force)) void **)&(p)))
> // would like instead:
> //#define __force_rcu_cast(p) ((__attribute__((force_bitwise)) typeof=
(p)) (p))
> #else /* not bitwise */
> #define __rcu __attribute__((address_space(3)))
> #define __force_rcu_cast(p) (*((__attribute__((force)) void **)&(p)))
> // would like instead:
> //#define __force_rcu_cast(p) ((__attribute__((force_address_space)) =
typeof(p)) (p))
> #endif
>=20
> #else /* not checker */
> #define __rcu
> #define __force_rcu_cast(p) (p)
> #endif
>=20
> #define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
>=20
> #define rcu_dereference(p)     ({ \
> 				typeof(p) _________p1 =3D ACCESS_ONCE(p); \
> 				smp_read_barrier_depends(); \
> 				__force_rcu_cast(_________p1); \
> 				})
>=20
> /**
>  * rcu_fetch - fetch an RCU-protected pointer in the update-locked
>  * critical section.
>  *
>  * This macro exists for documentation and code checking purposes.
>  */
> #define rcu_fetch(p)     __force_rcu_cast(p);
>=20
> #define rcu_assign_pointer(p, v) \
> 	({ \
> 		if (!__builtin_constant_p(v) || \
> 		    ((v) !=3D NULL)) \
> 			smp_wmb(); \
> 		__force_rcu_cast(p) =3D (v); \
> 	})
>=20
>=20
> test.c:
>=20
> #include <stdlib.h>
> #include "rcupdate.h"
>=20
> /* my rcu protected variables */
> static unsigned int __rcu *prot;
> static unsigned int __rcu *prot_same;
> static unsigned char __rcu *prot2;
>=20
> // dummies
> static smp_read_barrier_depends(void) {}
> static smp_wmb(void) {}
>=20
> int main(void)
> {
> 	unsigned int *tmp;
>=20
> 	// no warnings from sparse due to forced cast
> 	rcu_assign_pointer(prot, tmp);
> 	// but gcc warns
> 	rcu_assign_pointer(prot2, tmp);
>=20
> 	// no warnings
> 	rcu_assign_pointer(prot, NULL);
> 	rcu_assign_pointer(prot2, NULL);
>=20
> 	// no warnings
> 	prot =3D NULL;
> 	prot2 =3D NULL;
>=20
> 	// no warnings from sparse due to forced cast
> 	tmp =3D rcu_dereference(prot);
> 	// but gcc warns
> 	tmp =3D rcu_dereference(prot2);
>=20
> 	/* now within locked section rcu_dereference isn't required */
>=20
> 	// no warnings from sparse due to forced cast
> 	tmp =3D rcu_fetch(prot);
> 	// but gcc warns
> 	tmp =3D rcu_fetch(prot2);
>=20
> 	/* not caught with address_space, but is caught with bitwise */
> 	prot =3D prot_same;
> }
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
