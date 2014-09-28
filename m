From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/1] jffs2: fix sparse warning: unexpected unlock
Date: Sun, 28 Sep 2014 02:56:50 -0700
Message-ID: <20140928095650.GA24178@thin>
References: <1411065976-20386-1-git-send-email-fabf@skynet.be>
 <20140922181250.GN1193@ld-irv-0074>
 <20140926231727.GD20917@cloud>
 <1745266822.710655.1411807315752.open-xchange@webmail.nmp.skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37428 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaI1J5C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Sep 2014 05:57:02 -0400
Content-Disposition: inline
In-Reply-To: <1745266822.710655.1411807315752.open-xchange@webmail.nmp.skynet.be>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Sat, Sep 27, 2014 at 10:41:55AM +0200, Fabian Frederick wrote:
>=20
>=20
> > On 27 September 2014 at 01:17 josh@joshtriplett.org wrote:
> >
> >
> > On Mon, Sep 22, 2014 at 11:12:50AM -0700, Brian Norris wrote:
> > > + linux-sparse
> > >
> > > On Thu, Sep 18, 2014 at 08:46:16PM +0200, Fabian Frederick wrote:
> > > > fs/jffs2/summary.c:846:5: warning: context imbalance in
> > > > 'jffs2_sum_write_sumnode' - unexpected unlock
> > > >
> > > > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> > > > ---
> > > >=A0 fs/jffs2/summary.c | 2 ++
> > > >=A0 1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
> > > > index c522d09..a0bac7b 100644
> > > > --- a/fs/jffs2/summary.c
> > > > +++ b/fs/jffs2/summary.c
> > > > @@ -844,6 +844,8 @@ static int jffs2_sum_write_data(struct jffs=
2_sb_info
> > > > *c, struct jffs2_eraseblock
> > > >=A0 /* Write out summary information - called from jffs2_do_rese=
rve_space */
> > > >=A0
> > > >=A0 int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
> > > > + __releases(&c->erase_completion_lock)
> > > > + __acquires(&c->erase_completion_lock)
> > >
> > > I'm not too familiar with sparse notations, but Documentation/spa=
rse.txt
> > > suggests the above is wrong, and the following is more accurate:
> > >
> > >=A0 =A0 =A0__must_hold(&c->erase_completion_lock)
> > >
> > > But it looks like there are several other examples which do this.
> > > Anyway, here's the relevant doc text, in case someone wants to cl=
arify
> > > it for me, or else tell me the documentation is wrong:
> > >
> > >=A0 =A0 =A0__must_hold - The specified lock is held on function en=
try and exit.
> > >
> > >=A0 =A0 =A0__acquires - The specified lock is held on function exi=
t, but not entry.
> > >
> > >=A0 =A0 =A0__releases - The specified lock is held on function ent=
ry, but not exit.
> > >
> > > So __acquires and __releases look mutually exclusive, but it's no=
t clear
> > > if __must_hold will actually cover what we want. (I haven't teste=
d it.)
> >
> > __must_hold is indeed the correct annotation.=A0 (There isn't curre=
ntly
> > anything enforcing that, though.)
> >
> > - Josh Triplett
>=20
> There are 137 __releases && __acquires annotated functions in stable.
>=20
> AFAICS those are based on lock held on function entry / lock held on =
exit
>=20
> See
> fs/fuse/file.c:1527
> fs/kernfs/dir.c:341
> drivers/block/nbd.c:564
>=20
> Does it mean that all of these should be updated to __must_hold ?

Not really worth changing yet until something actually pays closer
attention to those annotations.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
