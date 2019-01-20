From: Tycho Andersen <tycho@tycho.ws>
Subject: Re: [RFC v1 0/4] static analysis of copy_to_user()
Date: Mon, 21 Jan 2019 08:05:10 +1300
Message-ID: <20190120190510.GC3987@cisco>
References: <20181220195931.20331-1-tycho@tycho.ws>
 <20181221224717.zixqkz26xujllmq4@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-hardening-return-14940-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Disposition: inline
In-Reply-To: <20181221224717.zixqkz26xujllmq4@ltop.local>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, kernel-hardening@lists.openwall.com
List-Id: linux-sparse@vger.kernel.org

Hey Luc,

On Fri, Dec 21, 2018 at 11:47:19PM +0100, Luc Van Oostenryck wrote:
> On Thu, Dec 20, 2018 at 12:59:27PM -0700, Tycho Andersen wrote:
> > Hi all,
> > 
> > A while ago I talked with various people about whether some static
> > analsys of copy_to_user() could be productive in finding infoleaks.
> > Unfortunately, due to the various issues outlined in the patch notes, it
> > doesn't seem like it is. Perhaps these checks are useful to put in just
> > to future proof ourselves against these sorts of issues, though.
> > 
> > Anyway, here's the code. Thoughts welcome!
> 
> Hi,
> 
> I'm taking the first patch directly but I won't be able to look
> closer at the other patches until next week.

Any chance you can take a peek at these?

Cheers,

Tycho
