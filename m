From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Staging/comedi: Fixes static analysis warning raised by
 sparse
Date: Mon, 30 Jun 2014 11:32:21 -0700
Message-ID: <CANeU7QmdB0Ec0ytBiLqW+QRMr_2_Eq-6hnraCb0nQtuY8-0N2w@mail.gmail.com>
References: <53965E53.5080504@gmail.com> <20140610054741.GE5500@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9AE6A@P3PWEX4MB008.ex4.secureserver.net>
 <20140611065612.GQ5015@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
 <20140611212425.GW5015@mwanda> <20140611214529.GB16940@cloud>
 <CANeU7Qki9Fg=Vz8gryT1bL+BMnjuvWZTH7uNvyk-HjdSPsiiyg@mail.gmail.com>
 <20140628192020.GA2501@thin>
 <CANeU7QkKnh-Xq4CVAkNFs54KieNrDqD93uuWijCOYwj0iorHvg@mail.gmail.com>
 <CANeU7QmOq7iqy8--A3srr0yMQ4f92BRi9wrLT1pYAHYstwsToA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CANeU7QmOq7iqy8--A3srr0yMQ4f92BRi9wrLT1pYAHYstwsToA@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, "Marcos A. Di Pietro" <marcosadp@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Jun 30, 2014 at 10:49 AM, Christopher Li <sparse@chrisli.org> wrote:
> The warning should be trivial in instruction level. We are looking
> for an instruction has larger than type size constant shift
> value.

Actually, just try it. Not as trivial as I thought.

The problem is that, in the instruction level, sparse will optimize away
the shift instruction when it see a larger than type size shift.
The finial instruction level don't see the big constant shift any way.
Need to catch it before the instruction get optimized away.

That is unfortunate. If we check it too early, we can't tell it is in the
dead code. If we check it too late, the instruction itself get optimized
away.

Chris
