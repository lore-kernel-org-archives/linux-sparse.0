From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Date: Mon, 2 Jul 2018 13:33:21 -0700
Message-ID: <20180702203321.GA8371@bombadil.infradead.org>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kostya Serebryany <kcc@google.com>
Cc: mark.rutland@arm.com, Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com, Paul Lawrence <paullawrence@google.com>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, cpandya@codeaurora.org, cl@linux.com, mingo@kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org, geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org, aryabinin@virtuozzo.com, dave.martin@arm.com, Evgeniy Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>, arnd@arndb.de, linux-kbuild@vger.kernel.org, marc.zyngier@arm.com, Andrey Konovalov <andreyknvl@google.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, rppt@linux.vnet.ibm.com, Dmitry
List-Id: linux-sparse@vger.kernel.org

On Wed, Jun 27, 2018 at 05:04:28PM -0700, Kostya Serebryany wrote:
> The problem is more significant on mobile devices than on desktop/server.
> I'd love to have [K]HWASAN on x86_64 as well, but it's less trivial since x86_64
> doesn't have an analog of aarch64's top-byte-ignore hardware feature.

Well, can we emulate it in software?

We've got 48 bits of virtual address space on x86.  If we need all 8
bits, then that takes us down to 40 bits (39 bits for user and 39 bits
for kernel).  My laptop only has 34 bits of physical memory, so could
we come up with a memory layout which works for me?
