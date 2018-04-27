From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Bug#873508: sparse test failures & PATH_MAX
Date: Fri, 27 Apr 2018 18:11:11 +0200
Message-ID: <20180427161110.3apj6vx4q2imbm3e@ltop.local>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org> <779a85fe-0691-0f8b-c70a-85df449003bc@kleine-koenig.org> <20180427073258.ga6i5maalktyukxu@ltop.local> <fffc3da7-186a-62d2-f1ef-1a6e95d4d613@kleine-koenig.org> <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
Reply-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 873508@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.873508.B873508.152484547729093@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <fffc3da7-186a-62d2-f1ef-1a6e95d4d613@kleine-koenig.org>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Apr 27, 2018 at 09:33:55AM +0200, Uwe Kleine-König wrote:
> On 04/27/2018 09:33 AM, Luc Van Oostenryck wrote:
> > On Fri, Apr 27, 2018 at 07:56:38AM +0200, Uwe Kleine-König wrote:
> >> Hello,
> >>
> >>> [..]
> >>
> >> Just a heads up: I uploaded 0.5.2 to Debian and there are problems left
> >> on hurd-i386 (where PATH_MAX isn't defined[1])
> >> ...
> >> [1]
> >> https://buildd.debian.org/status/fetch.php?pkg=sparse&arch=hurd-i386&ver=0.5.2-1&stamp=1524168405&raw=0
> > 
> > Thanks for the repport.
> > I'll see what can be done.
> 
> I think the default idiom is:
> 
> #ifndef PATH_MAX
> #define PATH_MAX 4096
> #endif

Yes.
I had hoped to avoid this together with removing a memcpy() but things are
more annoying than I had first thought.

Best regards,
-- Luc
