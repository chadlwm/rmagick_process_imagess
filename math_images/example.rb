require 'gnuplot.rb'
Gnuplot.open { |gp|
    Gnuplot::Plot.new( gp ) { |plot|
        plot.output "testgnu.pdf"
        plot.terminal "pdf colour size 27cm,19cm"

        plot.xrange "[-10:10]"
        plot.title  "Sin Wave Example"
        plot.ylabel "x"
        plot.xlabel "sin(x)"

        plot.data << Gnuplot::DataSet.new( "sin(x)" ) { |ds|
            ds.with = "lines"
            ds.linewidth = 4
        }
        plot.data << Gnuplot::DataSet.new( "cos(x)" ) { |ds|
            ds.with = "impulses"
            ds.linewidth = 4
        }
    }
}