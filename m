From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Thu, 07 Jun 2018 11:03:19 +0200
Message-ID: <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Du, Changbin" <changbin.du@intel.com>
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com, changbin.du@gmail.com, alex.elder@linaro.org, kbuild test robot <lkp@intel.com>, x86@kernel.org, linux@armlinux.org.uk, linux-sparse@vger.kernel.org, mingo@redhat.com, linux-arch@vger.kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, broonie@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, michal.lkml@markovi.net, gregkh@linuxfoundation.org, rdunlap@infradead.org, lgirdwood@gmail.com, kbuild-all@01.org, akpm@linux-foundation.org
List-Id: linux-sparse@vger.kernel.org

On Thu, 2018-06-07 at 14:08 +0530, Viresh Kumar wrote:
> On 07-06-18, 15:46, Du, Changbin wrote:
> > I think if the destination is not a null terminated string (If I understand your
> > description below), memcpy can be used to get rid of such warning. The warning
> > makes sense in general as explained in mannual. Thanks!
> 
> The destination should be a null terminated string eventually, but we first need
> to make sure src is a null terminated string.

Is there strnlen() or memchr() in the kernel?
Then check the source before copying it.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
