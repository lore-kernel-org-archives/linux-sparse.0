From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] New attribute designated_init: mark a struct as
 requiring designated init
Date: Sat, 10 Oct 2009 09:03:05 -0700
Message-ID: <20091010160304.GA11876@feather>
References: <20091010085732.GA10923@feather>
 <70318cbf0910100333m128e3500vb1659a55a9f49768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761974AbZJJQSA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <70318cbf0910100333m128e3500vb1659a55a9f49768@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Oct 10, 2009 at 03:33:20AM -0700, Christopher Li wrote:
> On Sat, Oct 10, 2009 at 1:58 AM, Josh Triplett <josh@joshtriplett.org=
> wrote:
> > Some structure types provide a set of fields of which most users wi=
ll
> > only initialize the subset they care about. =A0Users of these types=
 should
> > always use designated initializers, to avoid relying on the specifi=
c
> > structure layout. =A0Examples of this type of structure include the=
 many
>=20
> The patch is very well written with nice documentations and test case=
=2E
> It applies and runs fine.
>=20
> I am curious weather this is some thing the kernel developers want to
> use. Please speak up if you want to annotate the kernel structure to
> issue such warning. If some one use it, I have no problem adding it t=
o
> sparse.

After getting this patch reviewed, I intended to add many such
annotations myself.  I have patches sitting in my local Linux tree.
(However, I don't plan to try to get the patches accepted into Linux
until this attribute shows up in a Sparse release, since I don't want t=
o
make Linux require the latest Sparse from the git tree.)

> I am not sure how useful this is yet.  If the structure is changed, m=
ost
> likely the positional initialization will fail due to type mismatchin=
g.
> Some real life example how this feature can expose some otherwise
> hard to detect bug would be nice.

You *hope* that positional initialization will fail. :)  Some of these
types of structures contain many fields with the same or similar types,
and initializers don't inherently contain a lot of distinguishing type
information that helps cause type errors rather than silent failures.

Even if the positional initialization does fail, this failure will occu=
r
at the time of attempting to change the structure, and many such
failures may occur all over the tree, making such changes significantly
more difficult.  With the designated_init attribute, sparse will warn
when attempting to create the structure initializer.

With the designated_init attribute, someone making changes to a
structure can check that Sparse produces no warnings about positional
initializers and then know that certain types of changes can occur
without having to check every initializer.  For instance, removing a
field will only require checking any initializer that initializes that
field, and the compiler will find all of those.  Adding a field that ca=
n
safely remain NULL does not require checking any initializers.

> With this approach, we need to annotate the kernel to benefit from it=
=2E
> Another idea is that we can find out how different part of the kernel
> initialize the same structure. If most of them using designated init =
then
> the few non-conforming can get a warning. This approach is more
> complicate.  But it does not need to change the kernel.

I agree that we could infer certain types of warnings by saying "99% of
the kernel does $FOO, but this bit of code doesn't".  Other static
analysis tools do similar things.  However, such analyses can easily
lead to false positives, and they prove far more difficult to implement=
=2E
Having an explicit attribute works now, and also provides useful
documentation of the intended use of a structure.

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 warni=
ng(e->pos, "%s%s%spositional init of field in %s %s, declared with attr=
ibute designated_init",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ctype->ident ? "in initializer for " : "",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ctype->ident ? ctype->ident->name : "",
>=20
> ident->name has no guarantee of terminating by NUL.
> You want to use "%.*s" with ident->size, ident->name here.

Good catch; will fix and send new patch.

(As an aside, though: any fundamental reason why we use that error-pron=
e
approach rather than allocating one extra byte and NUL-terminating
idents?  Then we could drop the (larger) len field, and remove the
annoying restriction on calling show_ident multiple times in the same
statement.)

- Josh Triplett
