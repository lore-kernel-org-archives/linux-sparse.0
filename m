From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] adding into middle of RCU list
Date: Thu, 29 Aug 2013 19:16:37 -0700
Message-ID: <20130830021637.GA21862@leaf>
References: <20130822213318.49a57fa2@nehalam.linuxnetplumber.net>
	<20130823164637.GB3871@linux.vnet.ibm.com>
	<20130823171653.GA16558@Krystal>
	<20130823210822.GD3871@linux.vnet.ibm.com>
	<20130830005733.GA20664@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Content-Disposition: inline
In-Reply-To: <20130830005733.GA20664@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, lttng-dev@lists.lttng.org, linux-sparse@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, sparse@chrisli.org
List-Id: linux-sparse@vger.kernel.org

On Thu, Aug 29, 2013 at 05:57:33PM -0700, Paul E. McKenney wrote:
> On Fri, Aug 23, 2013 at 02:08:22PM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 23, 2013 at 01:16:53PM -0400, Mathieu Desnoyers wrote:
> > > #define __rcu_assign_pointer(p, v, space) \
> > >         do { \
> > >                 smp_wmb(); \
> > >                 (p) = (typeof(*v) __force space *)(v); \
> > >         } while (0)
> > 
> > Or I need to fix this one as well.  ;-)
> 
> In that vein...  Is there anything like typeof() that also preserves
> sparse's notion of address space?  Wrapping an ACCESS_ONCE() around
> "p" in the assignment above results in sparse errors.

typeof() will preserve sparse's notion of address space as long as you
do typeof(p), not typeof(*p):

$ cat test.c
#define as(n) __attribute__((address_space(n),noderef))
#define __force __attribute__((force))

int main(void)
{
    int target = 0;
    int as(1) *foo = (__force typeof(target) as(1) *) &target;
    typeof(foo) bar = foo;
    return *bar;
}
$ sparse test.c
test.c:9:13: warning: dereference of noderef expression

Notice that sparse didn't warn on the assignment of foo to bar (because
typeof propagated the address space of 1), and warned on the dereference
of bar (because typeof propagated noderef).

- Josh Triplett
