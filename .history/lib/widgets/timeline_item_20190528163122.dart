import 'im';


class TimelineItem extends StatelessWidget {
  final Color lineColor;
  final Color backgroundColor;
  final TemplateClass model;
  final bool firstElement;
  final bool lastElement;
  final Animation<double> controller;
  final Color headingColor;
  final Color descriptionColor;

  TimelineItem(
      {@required this.lineColor,
      @required this.backgroundColor,
      @required this.model,
      this.firstElement = false,
      this.lastElement = false,
      this.controller,
      this.headingColor,
      this.descriptionColor});

  Widget _buildLine(BuildContext context, Widget child) {
    return new Container(
      width: 40.0,
      child: new CustomPaint(
        painter: new TimelinePainter(
            lineColor: lineColor,
            backgroundColor: backgroundColor,
            firstElement: firstElement,
            lastElement: lastElement,
            controller: controller),
      ),
    );
  }

  Widget _buildContentColumn(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(bottom: 5.0, top: 23.0),
          child: Column(
            children: <Widget>[
              new Text(
                'Hello Heading',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: headingColor != null ? headingColor : Colors.black,
                ),
              ),
              new Text(
                'Hello Heading',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: headingColor != null ? headingColor : Colors.black,
                ),
              ),
              new Text(
                'Hello Heading',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: headingColor != null ? headingColor : Colors.black,
                ),
              ),
              new Text(
                'Hello Heading',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: headingColor != null ? headingColor : Colors.black,
                ),
              ),
              new Text(
                'Hello Heading',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: headingColor != null ? headingColor : Colors.black,
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context) {
    return new Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      constraints: BoxConstraints(minHeight: 80.0, minWidth: MediaQuery.of(context).size.width),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new AnimatedBuilder(
            builder: _buildLine,
            animation: controller,
          ),
          new Expanded(
            child: _buildContentColumn(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildRow(context);
  }
}
